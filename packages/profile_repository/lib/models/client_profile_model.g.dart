// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientProfileModel _$ClientProfileModelFromJson(Map<String, dynamic> json) => ClientProfileModel(
  success: json['success'] as bool,
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ClientProfileModelToJson(ClientProfileModel instance) => <String, dynamic>{
  'success': instance.success,
  'user': instance.user,
};
