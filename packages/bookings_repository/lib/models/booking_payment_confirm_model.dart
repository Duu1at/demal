import 'package:bookings_repository/bookings_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'booking_payment_confirm_model.g.dart';

@JsonSerializable()
@immutable
final class BookingPaymentConfirmModel {
  const BookingPaymentConfirmModel({
    required this.success,
    required this.message,
    required this.booking,
  });

  factory BookingPaymentConfirmModel.fromJson(Map<String, dynamic> json) => _$BookingPaymentConfirmModelFromJson(json);

  final bool success;
  final String message;
  final BookingModel booking;

  Map<String, dynamic> toJson() => _$BookingPaymentConfirmModelToJson(this);
}
