// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tour_review_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTourReviewParam _$CreateTourReviewParamFromJson(
  Map<String, dynamic> json,
) => CreateTourReviewParam(
  tourId: json['tour_id'] as String,
  text: json['text'] as String,
  rating: json['rating'] as num? ?? 0,
);

Map<String, dynamic> _$CreateTourReviewParamToJson(
  CreateTourReviewParam instance,
) => <String, dynamic>{
  'tour_id': instance.tourId,
  'rating': instance.rating,
  'text': instance.text,
};
