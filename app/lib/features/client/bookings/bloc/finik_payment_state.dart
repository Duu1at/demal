part of 'finik_payment_bloc.dart';

sealed class FinikPaymentState extends Equatable {
  const FinikPaymentState();

  @override
  List<Object> get props => [];
}

final class FinikPaymentInitial extends FinikPaymentState {
  const FinikPaymentInitial();
}

final class FinikPaymentVerifying extends FinikPaymentState {
  const FinikPaymentVerifying();
}

final class FinikPaymentPaid extends FinikPaymentState {
  const FinikPaymentPaid();
}

final class FinikPaymentProcessing extends FinikPaymentState {
  const FinikPaymentProcessing();
}

final class FinikPaymentFailed extends FinikPaymentState {
  const FinikPaymentFailed();
}

final class FinikPaymentError extends FinikPaymentState {
  const FinikPaymentError(this.error);
  final Object error;

  @override
  List<Object> get props => [error];
}
