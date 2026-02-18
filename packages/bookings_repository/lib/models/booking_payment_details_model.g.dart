// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_payment_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingPaymentDetailsModel _$BookingPaymentDetailsModelFromJson(
  Map<String, dynamic> json,
) => BookingPaymentDetailsModel(
  status: json['status'] as String?,
  provider: json['provider'] as String?,
  amount: (json['amount'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  transactionId: json['transaction_id'] as String?,
  paymentDate: json['payment_date'] as String?,
  requestId: json['request_id'] as String?,
);

Map<String, dynamic> _$BookingPaymentDetailsModelToJson(
  BookingPaymentDetailsModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'provider': instance.provider,
  'amount': instance.amount,
  'currency': instance.currency,
  'transaction_id': instance.transactionId,
  'payment_date': instance.paymentDate,
  'request_id': instance.requestId,
};
