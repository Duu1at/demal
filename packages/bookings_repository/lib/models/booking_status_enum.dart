import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum BookingStatusEnum {
  @JsonValue('PENDING')
  pending,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELLED')
  cancelled,
  @JsonValue('CONFIRMED')
  confirmed,
  @JsonValue('PAID')
  paid,
}
