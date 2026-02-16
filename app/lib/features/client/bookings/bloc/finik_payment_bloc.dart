import 'package:bookings_repository/bookings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'finik_payment_event.dart';
part 'finik_payment_state.dart';

class FinikPaymentBloc extends Bloc<FinikPaymentEvent, FinikPaymentState> {
  FinikPaymentBloc(this.bookingsRepository) : super(const FinikPaymentInitial()) {
    on<FinikPaymentVerifyRequested>(_onVerifyRequested);
    on<FinikPaymentFailedReported>(_onFailedReported);
  }

  final BookingsRepository bookingsRepository;

  Future<void> _onVerifyRequested(
    FinikPaymentVerifyRequested event,
    Emitter<FinikPaymentState> emit,
  ) async {
    emit(const FinikPaymentVerifying());
    try {
      const maxChecks = 5;
      for (var i = 0; i < maxChecks; i++) {
        final status = await bookingsRepository.getBookingPaymentStatus(event.bookingId);
        final isPaid =
            (status.paymentStatus ?? '').toUpperCase() == 'PAID' ||
            (status.bookingStatus ?? '').toUpperCase() == 'PAID';
        if (isPaid) {
          emit(const FinikPaymentPaid());
          return;
        }
        if (i < maxChecks - 1) {
          await Future<void>.delayed(const Duration(seconds: 2));
        }
      }
      emit(const FinikPaymentProcessing());
    } on Object catch (error) {
      emit(FinikPaymentError(error));
    }
  }

  void _onFailedReported(
    FinikPaymentFailedReported event,
    Emitter<FinikPaymentState> emit,
  ) {
    emit(const FinikPaymentFailed());
  }
}
