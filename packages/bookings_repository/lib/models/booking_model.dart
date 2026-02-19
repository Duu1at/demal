import 'package:bookings_repository/bookings_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'booking_model.g.dart';

@JsonSerializable()
@immutable
final class BookingModel {
  const BookingModel({
    this.bookingId,
    this.tour,
    this.seatsCount,
    this.totalAmount,
    this.status,
    this.name,
    this.email,
    this.phone,
    this.paymentDetails,
    this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

  @JsonKey(name: 'booking_id')
  final String? bookingId;
  @JsonKey(name: 'tour')
  final BookingTourModel? tour;
  @JsonKey(name: 'seats_count')
  final int? seatsCount;
  @JsonKey(name: 'total_amount')
  final int? totalAmount;
  @JsonKey(name: 'status')
  final BookingStatusEnum? status;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'payment_details')
  final BookingPaymentDetailsModel? paymentDetails;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
