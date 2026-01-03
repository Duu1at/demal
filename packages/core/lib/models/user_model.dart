import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModel {
  const UserModel({
    this.fullName,
    this.role = RoleEnum.GUEST,
    this.imageUrl,
    this.createdAt,
    this.userId,
    this.email,
    this.partnerProfile,
  });

  const UserModel.empty()
    : role = RoleEnum.GUEST,
      userId = '',
      fullName = '',
      imageUrl = '',
      createdAt = '',
      partnerProfile = null,
      email = '';

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'full_name')
  final String? fullName;

  final RoleEnum role;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'partner_profile')
  final PartnerProfileModel? partnerProfile;

  final String? email;

  bool get isPartner => role == RoleEnum.PARTNER;
  bool get isClient => role == RoleEnum.CLIENT;

  UserModel copyWith({
    String? userId,
    String? fullName,
    RoleEnum? role,
    String? imageUrl,
    String? createdAt,
    PartnerProfileModel? partnerProfile,
    String? email,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      partnerProfile: partnerProfile ?? this.partnerProfile,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
