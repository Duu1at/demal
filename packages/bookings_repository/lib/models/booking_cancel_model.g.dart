// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_cancel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingCancelModel _$BookingCancelModelFromJson(Map<String, dynamic> json) => BookingCancelModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  booking: BookingModel.fromJson(json['booking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingCancelModelToJson(BookingCancelModel instance) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'booking': instance.booking,
};
