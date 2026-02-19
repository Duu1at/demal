import 'package:meta/meta.dart';

@immutable
final class BookingPaymentStatusModel {
  const BookingPaymentStatusModel({
    this.bookingId,
    this.bookingStatus,
    this.paymentStatus,
    this.amount,
    this.requestId,
    this.providerPaymentId,
  });

  factory BookingPaymentStatusModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    return BookingPaymentStatusModel(
      bookingId: _readString(data, 'booking_id'),
      bookingStatus: _readString(data, 'booking_status'),
      paymentStatus: _readString(data, 'payment_status'),
      amount: _readInt(data, 'amount'),
      requestId: _readString(data, 'request_id'),
      providerPaymentId: _readString(data, 'provider_payment_id'),
    );
  }

  final String? bookingId;
  final String? bookingStatus;
  final String? paymentStatus;
  final int? amount;
  final String? requestId;
  final String? providerPaymentId;
}

String? _readString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String && value.isNotEmpty) return value;
  return null;
}

int? _readInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is int) return value;
  if (value is num) return value.toInt();
  return null;
}
