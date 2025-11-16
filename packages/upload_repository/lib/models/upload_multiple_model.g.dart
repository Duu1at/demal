// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_multiple_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadMultipleModel _$UploadMultipleModelFromJson(Map<String, dynamic> json) => UploadMultipleModel(
  success: json['success'] as bool,
  data: (json['data'] as List<dynamic>).map((e) => UploadDataModel.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$UploadMultipleModelToJson(
  UploadMultipleModel instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};
