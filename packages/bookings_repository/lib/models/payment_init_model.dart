import 'package:meta/meta.dart';

@immutable
final class PaymentInitModel {
  const PaymentInitModel({
    this.bookingId,
    this.requestId,
    this.amount,
  });

  factory PaymentInitModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    return PaymentInitModel(
      bookingId: _readString(data, 'booking_id'),
      requestId: _readString(data, 'request_id'),
      amount: _readDouble(data, 'amount'),
    );
  }

  final String? bookingId;
  final String? requestId;
  final double? amount;
}

String? _readString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String && value.isNotEmpty) return value;
  return null;
}

double? _readDouble(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return null;
}
