import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'meeting_point_model.g.dart';

@JsonSerializable()
@immutable
final class MeetingPointModel {
  const MeetingPointModel({this.address, this.coordinates});

  factory MeetingPointModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingPointModelFromJson(json);

  final String? address;
  final String? coordinates;

  Map<String, dynamic> toJson() => _$MeetingPointModelToJson(this);
}
