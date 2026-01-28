// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToursModel _$ToursModelFromJson(Map<String, dynamic> json) => ToursModel(
  tours: (json['tours'] as List<dynamic>?)?.map((e) => TourModel.fromJson(e as Map<String, dynamic>)).toList(),
  success: json['success'] as bool?,
  pagination: json['pagination'] == null
      ? null
      : PaginationResponseModel.fromJson(
          json['pagination'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ToursModelToJson(ToursModel instance) => <String, dynamic>{
  'success': instance.success,
  'pagination': instance.pagination,
  'tours': instance.tours,
};
