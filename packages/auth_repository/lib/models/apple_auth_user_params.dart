import 'package:json_annotation/json_annotation.dart';

part 'apple_auth_user_params.g.dart';

@JsonSerializable()
class AppleAuthUserParams {
  const AppleAuthUserParams({
    required this.accessToken,
    required this.userId,
    required this.email,
    this.fullName,
    this.phoneNumber,
  });

  factory AppleAuthUserParams.fromJson(Map<String, dynamic> json) => _$AppleAuthUserParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AppleAuthUserParamsToJson(this);

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'user_id')
  final String userId;

  final String email;

  @JsonKey(name: 'full_name')
  final String? fullName;

  final String? phoneNumber;
}
