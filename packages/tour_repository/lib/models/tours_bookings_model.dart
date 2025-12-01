import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tours_bookings_model.g.dart';

@JsonSerializable()
@immutable
final class ToursBookingsModel {
  const ToursBookingsModel({
    this.success,
    this.bookings,
  });

  factory ToursBookingsModel.fromJson(Map<String, dynamic> json) => _$ToursBookingsModelFromJson(json);

  final bool? success;
  final List<TourBookingModel>? bookings;

  Map<String, dynamic> toJson() => _$ToursBookingsModelToJson(this);
}

@JsonSerializable()
@immutable
final class TourBookingModel {
  const TourBookingModel({
    this.bookingId,
    this.user,
    this.seatsCount,
    this.totalAmount,
    this.status,
    this.name,
    this.email,
    this.createdAt,
  });

  factory TourBookingModel.fromJson(Map<String, dynamic> json) => _$TourBookingModelFromJson(json);

  @JsonKey(name: 'booking_id')
  final String? bookingId;
  final TourBookingUserModel? user;

  @JsonKey(name: 'seats_count')
  final int? seatsCount;

  @JsonKey(name: 'total_amount')
  final int? totalAmount;

  final String? status;

  final String? name;

  final String? email;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$TourBookingModelToJson(this);
}

@JsonSerializable()
@immutable
final class TourBookingUserModel {
  const TourBookingUserModel({
    this.id,
    this.fullName,
    this.phoneNumber,
  });

  factory TourBookingUserModel.fromJson(Map<String, dynamic> json) => _$TourBookingUserModelFromJson(json);
  final String? id;
  final String? fullName;
  final String? phoneNumber;
  Map<String, dynamic> toJson() => _$TourBookingUserModelToJson(this);
}
