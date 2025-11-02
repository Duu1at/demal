// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      totalItems: (json['total_items'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
    };
