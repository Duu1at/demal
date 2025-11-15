import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'client_update_profile_param.g.dart';

@JsonSerializable()
@immutable
final class ClientUpdateProfileParam {
  const ClientUpdateProfileParam({
    required this.fullName,
    required this.imageUrl,
  });

  factory ClientUpdateProfileParam.fromJson(Map<String, dynamic> json) => _$ClientUpdateProfileParamFromJson(json);
  Map<String, dynamic> toJson() => _$ClientUpdateProfileParamToJson(this);

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'image_url')
  final String imageUrl;
}
