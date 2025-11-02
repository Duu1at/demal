import 'user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'auth_login_model.g.dart';

@JsonSerializable()
@immutable
final class AuthLoginModel {
  const AuthLoginModel({
    required this.success,
    required this.authToken,
    required this.isNewUser,
    required this.user,
  });

  factory AuthLoginModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginModelFromJson(json);

  final bool success;
  @JsonKey(name: 'auth_token')
  final String authToken;
  @JsonKey(name: 'is_new_user')
  final bool isNewUser;
  final UserModel user;

  Map<String, dynamic> toJson() => _$AuthLoginModelToJson(this);
}


