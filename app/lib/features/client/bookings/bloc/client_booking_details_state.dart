part of 'client_booking_details_bloc.dart';

enum ClientBookingDetailsValidationErrorType {
  missingTourId,
  nameRequired,
  amountMustBeGreaterThanZero,
  missingBookingIdFromBackend,
  missingRequestIdFromBackend,
}

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
  const ClientBookingDetailsValidationError(this.type);
  final ClientBookingDetailsValidationErrorType type;

  @override
  List<Object?> get props => [type];
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
