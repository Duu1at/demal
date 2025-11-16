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
  phoneNumber: json['phone_number'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'phone_number': instance.phoneNumber,
  'full_name': instance.fullName,
  'role': _$RoleEnumEnumMap[instance.role],
  'image_url': instance.imageUrl,
  'created_at': instance.createdAt,
};

const _$RoleEnumEnumMap = {
  RoleEnum.admin: 'ADMIN',
  RoleEnum.partner: 'PARTNER',
  RoleEnum.client: 'CLIENT',
  RoleEnum.unknown: '',
};
