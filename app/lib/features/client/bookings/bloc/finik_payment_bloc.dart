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
      final status = await bookingsRepository.getBookingPaymentStatus(event.bookingId);
      final paymentStatus = (status.paymentStatus ?? '').toUpperCase();
      final bookingStatus = (status.bookingStatus ?? '').toUpperCase();

      if (_isPaid(paymentStatus, bookingStatus)) {
        emit(const FinikPaymentPaid());
        return;
      }
      if (_isFailed(paymentStatus, bookingStatus)) {
        emit(const FinikPaymentFailed());
        return;
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

  bool _isPaid(String paymentStatus, String bookingStatus) {
    return paymentStatus == 'PAID' || bookingStatus == 'PAID';
  }

  bool _isFailed(String paymentStatus, String bookingStatus) {
    const failedStatuses = {'FAILED', 'CANCELLED', 'CANCELED', 'REJECTED', 'DECLINED', 'EXPIRED'};
    return failedStatuses.contains(paymentStatus) || failedStatuses.contains(bookingStatus);
  }
}
