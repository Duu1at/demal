import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tour_detail_model.g.dart';

@JsonSerializable()
@immutable
final class TourDetailModel {
  const TourDetailModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.duration,
    this.difficulty,
    this.location,
  });

  factory TourDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TourDetailModelFromJson(json);

  final String? id;
  final String? name;
  final String? description;
  final String? image;
  @JsonKey(name: 'price')
  final String? price;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'difficulty')
  final String? difficulty;
  @JsonKey(name: 'location')
  final String? location;

  Map<String, dynamic> toJson() => _$TourDetailModelToJson(this);
}
