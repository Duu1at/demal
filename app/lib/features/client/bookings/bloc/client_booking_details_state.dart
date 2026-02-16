part of 'client_booking_details_bloc.dart';

sealed class ClientBookingDetailsState extends Equatable {
  const ClientBookingDetailsState();

  @override
  List<Object?> get props => [];
}

final class ClientBookingDetailsInitial extends ClientBookingDetailsState {
  const ClientBookingDetailsInitial();
}

final class ClientBookingDetailsSubmitting extends ClientBookingDetailsState {
  const ClientBookingDetailsSubmitting();
}

final class ClientBookingDetailsValidationError extends ClientBookingDetailsState {
  const ClientBookingDetailsValidationError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

final class ClientBookingDetailsFailure extends ClientBookingDetailsState {
  const ClientBookingDetailsFailure(this.error);
  final Object error;

  @override
  List<Object?> get props => [error];
}

final class ClientBookingDetailsOpenPayment extends ClientBookingDetailsState {
  const ClientBookingDetailsOpenPayment(this.args);
  final FinikPaymentArgs args;

  @override
  List<Object?> get props => [args];
}
