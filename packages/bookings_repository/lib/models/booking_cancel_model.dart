import 'package:bookings_repository/bookings_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'booking_cancel_model.g.dart';

@JsonSerializable()
@immutable
final class BookingCancelModel {
  const BookingCancelModel({
    required this.success,
    required this.message,
    required this.booking,
  });

  factory BookingCancelModel.fromJson(Map<String, dynamic> json) => _$BookingCancelModelFromJson(json);

  final bool success;
  final String message;
  final BookingModel booking;

  Map<String, dynamic> toJson() => _$BookingCancelModelToJson(this);
}
