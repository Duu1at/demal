import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'organizer_model.g.dart';

@JsonSerializable()
@immutable
final class OrganizerModel {
  const OrganizerModel({
    required this.id,
    required this.fullName,
    required this.imageUrl,
  });

  factory OrganizerModel.fromJson(Map<String, dynamic> json) => _$OrganizerModelFromJson(json);

  final String id;
  @JsonKey(name: 'fullName')
  final String fullName;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  Map<String, dynamic> toJson() => _$OrganizerModelToJson(this);
}
