import 'package:auth_repository/enums/role_enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart' as profile_repo;

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
    this.partnerProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'full_name')
  final String? fullName;

  final RoleEnum? role;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'partner_profile')
  final profile_repo.PartnerProfileModel? partnerProfile;

  UserModel copyWith({
    String? userId,
    String? phoneNumber,
    String? fullName,
    RoleEnum? role,
    String? imageUrl,
    String? createdAt,
    profile_repo.PartnerProfileModel? partnerProfile,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      partnerProfile: partnerProfile ?? this.partnerProfile,
    );
  }

  bool get hasRole => role != null;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
