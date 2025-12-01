// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourReviewModel _$TourReviewModelFromJson(Map<String, dynamic> json) => TourReviewModel(
  reviewId: json['review_id'] as String?,
  tourId: json['tour_id'] as String?,
  user: json['user'] == null ? null : ReviewUserModel.fromJson(json['user'] as Map<String, dynamic>),
  rating: (json['rating'] as num?)?.toDouble(),
  text: json['text'] as String?,
  createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TourReviewModelToJson(TourReviewModel instance) => <String, dynamic>{
  'review_id': instance.reviewId,
  'tour_id': instance.tourId,
  'user': instance.user,
  'rating': instance.rating,
  'text': instance.text,
  'created_at': instance.createdAt?.toIso8601String(),
};

ReviewUserModel _$ReviewUserModelFromJson(Map<String, dynamic> json) => ReviewUserModel(
  id: json['id'] as String?,
  fullName: json['fullName'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ReviewUserModelToJson(ReviewUserModel instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'imageUrl': instance.imageUrl,
};
