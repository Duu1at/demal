import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'create_bookings_param.g.dart';

@JsonSerializable()
@immutable
final class CreateBookingsParam {
  const CreateBookingsParam({
    required this.tourId,
    required this.seatsCount,
    required this.name,
    this.email,
  });

  factory CreateBookingsParam.fromJson(Map<String, dynamic> json) => _$CreateBookingsParamFromJson(json);

  @JsonKey(name: 'tour_id')
  final String tourId;
  @JsonKey(name: 'seats_count')
  final int seatsCount;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'email')
  final String? email;

  Map<String, dynamic> toJson() => _$CreateBookingsParamToJson(this);
}
