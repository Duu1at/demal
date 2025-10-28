// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginModel _$AuthLoginModelFromJson(Map<String, dynamic> json) =>
    AuthLoginModel(
      success: json['success'] as bool,
      authToken: json['auth_token'] as String,
      isNewUser: json['is_new_user'] as bool,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthLoginModelToJson(AuthLoginModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'auth_token': instance.authToken,
      'is_new_user': instance.isNewUser,
      'user': instance.user,
    };
