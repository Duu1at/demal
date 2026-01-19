// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tours_bookings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToursBookingsModel _$ToursBookingsModelFromJson(Map<String, dynamic> json) =>
    ToursBookingsModel(
      success: json['success'] as bool?,
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => TourBookingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ToursBookingsModelToJson(ToursBookingsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'bookings': instance.bookings,
    };

TourBookingModel _$TourBookingModelFromJson(Map<String, dynamic> json) =>
    TourBookingModel(
      bookingId: json['booking_id'] as String?,
      user: json['user'] == null
          ? null
          : TourBookingUserModel.fromJson(json['user'] as Map<String, dynamic>),
      seatsCount: (json['seats_count'] as num?)?.toInt(),
      totalAmount: json['total_amount'] as String?,
      status: $enumDecodeNullable(_$BookingStatusEnumEnumMap, json['status']),
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TourBookingModelToJson(TourBookingModel instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'user': instance.user,
      'seats_count': instance.seatsCount,
      'total_amount': instance.totalAmount,
      'status': _$BookingStatusEnumEnumMap[instance.status],
      'name': instance.name,
      'email': instance.email,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$BookingStatusEnumEnumMap = {
  BookingStatusEnum.pending: 'PENDING',
  BookingStatusEnum.completed: 'COMPLETED',
  BookingStatusEnum.cancelled: 'CANCELLED',
  BookingStatusEnum.confirmed: 'CONFIRMED',
  BookingStatusEnum.paid: 'PAID',
};

TourBookingUserModel _$TourBookingUserModelFromJson(
  Map<String, dynamic> json,
) => TourBookingUserModel(
  id: json['id'] as String?,
  fullName: json['fullName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
);

Map<String, dynamic> _$TourBookingUserModelToJson(
  TourBookingUserModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'phoneNumber': instance.phoneNumber,
};
