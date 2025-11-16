// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_payment_confirm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingPaymentConfirmModel _$BookingPaymentConfirmModelFromJson(
  Map<String, dynamic> json,
) => BookingPaymentConfirmModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  booking: BookingModel.fromJson(json['booking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingPaymentConfirmModelToJson(
  BookingPaymentConfirmModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'booking': instance.booking,
};
