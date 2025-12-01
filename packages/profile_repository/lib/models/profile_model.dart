import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

part 'profile_model.g.dart';

@JsonSerializable()
@immutable
final class ProfileModel {
  const ProfileModel({
    required this.success,
    required this.user,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  final bool success;
  final UserModel user;

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

@JsonSerializable()
@immutable
final class UserModel {
  const UserModel({
    this.userId,
    this.phoneNumber,
    this.fullName,
    this.role,
    this.imageUrl,
    this.createdAt,
    this.partnerProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  final String? userId;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? role;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final PartnerProfileModel? partnerProfile;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
