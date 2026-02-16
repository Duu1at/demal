// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_bookings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingsModel _$CreateBookingsModelFromJson(Map<String, dynamic> json) => CreateBookingsModel(
  success: json['success'] as bool,
  data: CreateBookingModel.fromJson(
    json['data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CreateBookingsModelToJson(
  CreateBookingsModel instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

CreateBookingModel _$CreateBookingModelFromJson(Map<String, dynamic> json) => CreateBookingModel(
  bookingId: json['booking_id'] as String?,
  tour: json['tour'] == null
      ? null
      : CreateTourBookingModel.fromJson(
          json['tour'] as Map<String, dynamic>,
        ),
  seatsCount: (json['seats_count'] as num?)?.toInt(),
  totalAmount: (json['total_amount'] as num?)?.toInt(),
  status: $enumDecodeNullable(_$BookingStatusEnumEnumMap, json['status']),
  name: json['name'] as String?,
  email: json['email'] as String?,
  createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CreateBookingModelToJson(CreateBookingModel instance) => <String, dynamic>{
  'booking_id': instance.bookingId,
  'tour': instance.tour,
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

CreateTourBookingModel _$CreateTourBookingModelFromJson(
  Map<String, dynamic> json,
) => CreateTourBookingModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  time: json['time'] as String?,
);

Map<String, dynamic> _$CreateTourBookingModelToJson(
  CreateTourBookingModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'date': instance.date?.toIso8601String(),
  'time': instance.time,
};
