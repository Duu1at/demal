import 'package:auth_repository/enums/role_enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModel {
  const UserModel({
    this.fullName,
    this.role,
    this.imageUrl,
    this.createdAt,
    this.userId,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'full_name')
  final String? fullName;

  @JsonKey(fromJson: Role.fromString, toJson: _roleToJson)
  final Role? role;

  static String? _roleToJson(Role? role) => role?.toJson();

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  UserModel copyWith({
    String? userId,
    String? phoneNumber,
    String? fullName,
    Role? role,
    String? imageUrl,
    String? createdAt,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? createdAt,
    );
  }

  bool get hasRole => role != null;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
