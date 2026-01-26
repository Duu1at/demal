// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_auth_user_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleAuthUserParams _$GoogleAuthUserParamsFromJson(
  Map<String, dynamic> json,
) => GoogleAuthUserParams(
  accessToken: json['access_token'] as String,
  userId: json['user_id'] as String,
  email: json['email'] as String,
  fullName: json['full_name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
);

Map<String, dynamic> _$GoogleAuthUserParamsToJson(
  GoogleAuthUserParams instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'user_id': instance.userId,
  'email': instance.email,
  'full_name': instance.fullName,
  'avatar_url': instance.avatarUrl,
  'phoneNumber': instance.phoneNumber,
};
