import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'booking_tour_model.g.dart';

@JsonSerializable()
@immutable
final class BookingTourModel {
  const BookingTourModel({
    this.id,
    this.title,
    this.mainImageUrl,
    this.location,
    this.date,
    this.time,
    this.price,
  });

  factory BookingTourModel.fromJson(Map<String, dynamic> json) => _$BookingTourModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookingTourModelToJson(this);

  final String? id;
  final String? title;
  final String? mainImageUrl;
  final String? location;
  final DateTime? date;
  final String? time;
  final int? price;
}
