import 'package:json_annotation/json_annotation.dart';

part 'google_auth_user_params.g.dart';

@JsonSerializable()
class GoogleAuthUserParams {
  const GoogleAuthUserParams({
    required this.accessToken,
    required this.userId,
    required this.email,
    required this.fullName,
    this.avatarUrl,
    this.phoneNumber,
  });

  factory GoogleAuthUserParams.fromJson(Map<String, dynamic> json) => _$GoogleAuthUserParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleAuthUserParamsToJson(this);

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'user_id')
  final String userId;

  final String email;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  final String? phoneNumber;
}
