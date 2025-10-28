import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModel {
  const UserModel({
    required this.success,
    this.fullName,
    required this.role,
    this.imageUrl,
    required this.createdAt,
    required this.userId,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  final bool success;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final Role role;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'created_at')
  final String createdAt;
}

enum Role { client, partner }
