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
    this.phone,
    this.paymentInfo,
    this.updatedAt,
    this.createdAt,
  });

  factory TourBookingModel.fromJson(Map<String, dynamic> json) => _$TourBookingModelFromJson(json);

  @JsonKey(name: 'booking_id')
  final String? bookingId;
  final TourBookingUserModel? user;

  @JsonKey(name: 'seats_count')
  final int? seatsCount;

  @JsonKey(name: 'total_amount')
  final String? totalAmount;

  final BookingStatusEnum? status;

  final String? name;

  final String? email;

  final String? phone;

  @JsonKey(name: 'payment_info')
  final PaymentInfoModel? paymentInfo;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

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
    this.imageUrl,
    this.email,
  });

  factory TourBookingUserModel.fromJson(Map<String, dynamic> json) => _$TourBookingUserModelFromJson(json);
  final String? id;
  final String? fullName;
  final String? phoneNumber;
  final String? imageUrl;
  final String? email;
  Map<String, dynamic> toJson() => _$TourBookingUserModelToJson(this);
}

@JsonSerializable()
@immutable
final class PaymentInfoModel {
  const PaymentInfoModel({
    this.provider,
    this.status,
    this.amount,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) => _$PaymentInfoModelFromJson(json);

  final String? provider;
  final PaymentStatusEnum? status;
  final int? amount;

  Map<String, dynamic> toJson() => _$PaymentInfoModelToJson(this);
}

@JsonEnum()
enum BookingStatusEnum {
  @JsonValue('PENDING')
  pending,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELLED')
  cancelled,
  @JsonValue('CONFIRMED')
  confirmed,
  @JsonValue('PAID')
  paid,
}

@JsonEnum()
enum PaymentStatusEnum {
  @JsonValue('PENDING')
  pending,
  @JsonValue('PAID')
  paid,
  @JsonValue('FAILED')
  failed,
}
