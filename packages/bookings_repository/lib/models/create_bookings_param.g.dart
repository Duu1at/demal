// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_bookings_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingsParam _$CreateBookingsParamFromJson(Map<String, dynamic> json) => CreateBookingsParam(
  tourId: json['tour_id'] as String,
  seatsCount: (json['seats_count'] as num).toInt(),
  name: json['name'] as String,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$CreateBookingsParamToJson(
  CreateBookingsParam instance,
) => <String, dynamic>{
  'tour_id': instance.tourId,
  'seats_count': instance.seatsCount,
  'name': instance.name,
  'phone': instance.phone,
};
