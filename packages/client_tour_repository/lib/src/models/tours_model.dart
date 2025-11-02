import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tours_model.g.dart';

@JsonSerializable()
@immutable
final class ToursModel {
  const ToursModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.duration,
    this.difficulty,
    this.location,
  });

  factory ToursModel.fromJson(Map<String, dynamic> json) =>
      _$ToursModelFromJson(json);

  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final String? price;
  final String? duration;
  final String? difficulty;
  final String? location;
}
