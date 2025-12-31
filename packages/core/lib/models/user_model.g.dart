// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  fullName: json['full_name'] as String?,
  role: $enumDecodeNullable(_$RoleEnumEnumMap, json['role']),
  imageUrl: json['image_url'] as String?,
  createdAt: json['created_at'] as String?,
  userId: json['user_id'] as String?,
  email: json['email'] as String?,
  partnerProfile: json['partner_profile'] == null
      ? null
      : PartnerProfileModel.fromJson(
          json['partner_profile'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'full_name': instance.fullName,
  'role': _$RoleEnumEnumMap[instance.role],
  'image_url': instance.imageUrl,
  'created_at': instance.createdAt,
  'partner_profile': instance.partnerProfile,
  'email': instance.email,
};

const _$RoleEnumEnumMap = {
  RoleEnum.PARTNER: 'PARTNER',
  RoleEnum.CLIENT: 'CLIENT',
  RoleEnum.GUEST: '',
};
