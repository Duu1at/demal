// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_auth_user_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppleAuthUserParams _$AppleAuthUserParamsFromJson(Map<String, dynamic> json) =>
    AppleAuthUserParams(
      accessToken: json['access_token'] as String,
      userId: json['user_id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$AppleAuthUserParamsToJson(
  AppleAuthUserParams instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'user_id': instance.userId,
  'email': instance.email,
  'full_name': instance.fullName,
  'phoneNumber': instance.phoneNumber,
};
