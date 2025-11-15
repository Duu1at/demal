// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_update_profile_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientUpdateProfileParam _$ClientUpdateProfileParamFromJson(
  Map<String, dynamic> json,
) => ClientUpdateProfileParam(
  fullName: json['full_name'] as String,
  imageUrl: json['image_url'] as String,
);

Map<String, dynamic> _$ClientUpdateProfileParamToJson(
  ClientUpdateProfileParam instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'image_url': instance.imageUrl,
};
