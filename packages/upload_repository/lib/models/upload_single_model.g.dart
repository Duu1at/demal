// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_single_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadSingleModel _$UploadSingleModelFromJson(Map<String, dynamic> json) => UploadSingleModel(
  success: json['success'] as bool,
  data: UploadDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UploadSingleModelToJson(UploadSingleModel instance) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
};
