import 'package:bookings_repository/models/booking_status_enum.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:meta/meta.dart';

part 'create_bookings_model.g.dart';

@JsonSerializable()
@immutable
final class CreateBookingsModel {
  const CreateBookingsModel({
    required this.success,
    required this.data,
  });

  factory CreateBookingsModel.fromJson(Map<String, dynamic> json) => _$CreateBookingsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateBookingsModelToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'data')
  final CreateTourBookingModel data;
}

@JsonSerializable()
@immutable
final class CreateBookingModel {
  const CreateBookingModel({
    this.bookingId,
    this.tour,
    this.seatsCount,
    this.totalAmount,
    this.status,
    this.name,
    this.email,
    this.createdAt,
  });

  factory CreateBookingModel.fromJson(Map<String, dynamic> json) => _$CreateBookingModelFromJson(json);

  @JsonKey(name: 'booking_id')
  final String? bookingId;

  final CreateTourBookingModel? tour;

  @JsonKey(name: 'seats_count')
  final int? seatsCount;
  @JsonKey(name: 'total_amount')
  final int? totalAmount;
  @JsonKey(name: 'status')
  final BookingStatusEnum? status;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$CreateBookingModelToJson(this);
}

@JsonSerializable()
@immutable
final class CreateTourBookingModel {
  const CreateTourBookingModel({
    this.id,
    this.title,
    this.date,
    this.time,
  });

  factory CreateTourBookingModel.fromJson(Map<String, dynamic> json) => _$CreateTourBookingModelFromJson(json);

  final String? id;
  final String? title;
  final DateTime? date;
  final String? time;

  Map<String, dynamic> toJson() => _$CreateTourBookingModelToJson(this);
}
