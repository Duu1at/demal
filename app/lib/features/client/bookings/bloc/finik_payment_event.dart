part of 'finik_payment_bloc.dart';

sealed class FinikPaymentEvent extends Equatable {
  const FinikPaymentEvent();

  @override
  List<Object> get props => [];
}

final class FinikPaymentVerifyRequested extends FinikPaymentEvent {
  const FinikPaymentVerifyRequested(this.bookingId);
  final String bookingId;

  @override
  List<Object> get props => [bookingId];
}

final class FinikPaymentFailedReported extends FinikPaymentEvent {
  const FinikPaymentFailedReported();
}
