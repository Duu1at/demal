// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  success: json['success'] as bool,
  fullName: json['full_name'] as String?,
  role: $enumDecode(_$RoleEnumMap, json['role']),
  imageUrl: json['image_url'] as String?,
  createdAt: json['created_at'] as String,
  userId: json['user_id'] as String,
  phoneNumber: json['phone_number'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'success': instance.success,
  'user_id': instance.userId,
  'phone_number': instance.phoneNumber,
  'full_name': instance.fullName,
  'role': _$RoleEnumMap[instance.role]!,
  'image_url': instance.imageUrl,
  'created_at': instance.createdAt,
};

const _$RoleEnumMap = {Role.client: 'client', Role.partner: 'partner'};
