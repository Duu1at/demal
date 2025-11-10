// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToursModel _$ToursModelFromJson(Map<String, dynamic> json) => ToursModel(
  success: json['success'] as bool?,
  tours: (json['tours'] as List<dynamic>?)?.map((e) => TourModel.fromJson(e as Map<String, dynamic>)).toList(),
  pagination: json['pagination'] == null ? null : PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ToursModelToJson(ToursModel instance) => <String, dynamic>{
  'success': instance.success,
  'tours': instance.tours,
  'pagination': instance.pagination,
};
