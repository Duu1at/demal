// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tours_reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToursReviewsModel _$ToursReviewsModelFromJson(Map<String, dynamic> json) =>
    ToursReviewsModel(
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => TourReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
      pagination: json['pagination'] == null
          ? null
          : PaginationResponseModel.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ToursReviewsModelToJson(ToursReviewsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'pagination': instance.pagination,
      'reviews': instance.reviews,
    };
