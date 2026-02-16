import 'package:app/features/client/client.dart';
import 'package:bookings_repository/bookings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'client_booking_details_event.dart';
part 'client_booking_details_state.dart';

class ClientBookingDetailsBloc extends Bloc<ClientBookingDetailsEvent, ClientBookingDetailsState> {
  ClientBookingDetailsBloc(this._bookingsRepository) : super(const ClientBookingDetailsInitial()) {
    on<ClientBookingSubmitPressed>(_onSubmitPressed);
  }

  final BookingsRepository _bookingsRepository;

  Future<void> _onSubmitPressed(
    ClientBookingSubmitPressed event,
    Emitter<ClientBookingDetailsState> emit,
  ) async {
    if (event.tourId == null || event.tourId!.isEmpty) {
      emit(const ClientBookingDetailsValidationError('Tour id is missing'));
      return;
    }
    if (event.name.trim().isEmpty) {
      emit(const ClientBookingDetailsValidationError('Name is required'));
      return;
    }
    if (event.fallbackPaymentAmount <= 0) {
      emit(const ClientBookingDetailsValidationError('Amount must be greater than 0'));
      return;
    }

    emit(const ClientBookingDetailsSubmitting());
    try {
      final created = await _bookingsRepository.createBookings(
        CreateBookingsParam(
          tourId: event.tourId!,
          seatsCount: event.seatsCount,
          name: event.name.trim(),
          email: event.contact.trim().isEmpty ? null : event.contact.trim(),
        ),
      );

      final bookingId = created.data.bookingId;
      if (bookingId == null || bookingId.isEmpty) {
        emit(
          const ClientBookingDetailsValidationError(
            'Backend must return booking id after create booking',
          ),
        );
        emit(const ClientBookingDetailsInitial());
        return;
      }

      final initPayment = await _bookingsRepository.initPayment(bookingId);
      final requestId = initPayment.requestId;
      if (requestId == null || requestId.isEmpty) {
        emit(
          const ClientBookingDetailsValidationError(
            'Backend must return request_id from /payments/init',
          ),
        );
        emit(const ClientBookingDetailsInitial());
        return;
      }

      emit(
        ClientBookingDetailsOpenPayment(
          FinikPaymentArgs(
            bookingId: bookingId,
            requestId: requestId,
            amount: initPayment.amount ?? event.fallbackPaymentAmount,
            itemName: event.itemName,
          ),
        ),
      );
      emit(const ClientBookingDetailsInitial());
    } on Object catch (error) {
      emit(ClientBookingDetailsFailure(error));
      emit(const ClientBookingDetailsInitial());
    }
  }
}
