// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_bookings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBookingsModel _$MyBookingsModelFromJson(Map<String, dynamic> json) =>
    MyBookingsModel(
      success: json['success'] as bool,
      bookings: (json['bookings'] as List<dynamic>)
          .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MyBookingsModelToJson(MyBookingsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'bookings': instance.bookings,
      'pagination': instance.pagination,
    };

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      totalItems: (json['total_items'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
    };
