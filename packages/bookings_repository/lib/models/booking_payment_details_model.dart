import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'booking_payment_details_model.g.dart';

@JsonSerializable()
@immutable
final class BookingPaymentDetailsModel {
  const BookingPaymentDetailsModel({
    this.status,
    this.provider,
    this.amount,
    this.currency,
    this.transactionId,
    this.paymentDate,
    this.requestId,
  });

  factory BookingPaymentDetailsModel.fromJson(Map<String, dynamic> json) => _$BookingPaymentDetailsModelFromJson(json);

  final String? status;
  final String? provider;
  final int? amount;
  final String? currency;
  @JsonKey(name: 'transaction_id')
  final String? transactionId;
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  @JsonKey(name: 'request_id')
  final String? requestId;

  Map<String, dynamic> toJson() => _$BookingPaymentDetailsModelToJson(this);
}
