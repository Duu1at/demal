// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
  bookingId: json['booking_id'] as String?,
  tour: json['tour'] == null
      ? null
      : BookingTourModel.fromJson(json['tour'] as Map<String, dynamic>),
  seatsCount: (json['seats_count'] as num?)?.toInt(),
  totalAmount: (json['total_amount'] as num?)?.toInt(),
  status: $enumDecodeNullable(_$BookingStatusEnumEnumMap, json['status']),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  paymentDetails: json['payment_details'] == null
      ? null
      : BookingPaymentDetailsModel.fromJson(
          json['payment_details'] as Map<String, dynamic>,
        ),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'tour': instance.tour,
      'seats_count': instance.seatsCount,
      'total_amount': instance.totalAmount,
      'status': _$BookingStatusEnumEnumMap[instance.status],
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'payment_details': instance.paymentDetails,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$BookingStatusEnumEnumMap = {
  BookingStatusEnum.pending: 'PENDING',
  BookingStatusEnum.completed: 'COMPLETED',
  BookingStatusEnum.cancelled: 'CANCELLED',
  BookingStatusEnum.confirmed: 'CONFIRMED',
  BookingStatusEnum.paid: 'PAID',
};
