import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'profile_update_param.g.dart';

@JsonSerializable(includeIfNull: false)
@immutable
final class ProfileUpdateParam {
  const ProfileUpdateParam({
    this.fullName,
    this.imageUrl,
    this.phoneNumber,
    this.description,
  });

  factory ProfileUpdateParam.fromJson(Map<String, dynamic> json) => _$ProfileUpdateParamFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileUpdateParamToJson(this);

  @JsonKey(name: 'full_name')
  final String? fullName;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'description')
  final String? description;
}
