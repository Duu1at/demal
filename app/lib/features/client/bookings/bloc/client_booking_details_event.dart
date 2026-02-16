part of 'client_booking_details_bloc.dart';

sealed class ClientBookingDetailsEvent extends Equatable {
  const ClientBookingDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class ClientBookingSubmitPressed extends ClientBookingDetailsEvent {
  const ClientBookingSubmitPressed({
    required this.tourId,
    required this.seatsCount,
    required this.name,
    required this.contact,
    required this.fallbackPaymentAmount,
    required this.itemName,
  });

  final String? tourId;
  final int seatsCount;
  final String name;
  final String contact;
  final int fallbackPaymentAmount;
  final String itemName;

  @override
  List<Object?> get props => [
    tourId,
    seatsCount,
    name,
    contact,
    fallbackPaymentAmount,
    itemName,
  ];
}
