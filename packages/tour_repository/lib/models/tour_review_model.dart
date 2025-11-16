import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tour_review_model.g.dart';

@JsonSerializable()
@immutable
final class TourReviewModel {
  const TourReviewModel({
    this.reviewId,
    this.tourId,
    this.user,
    this.rating,
    this.text,
    this.createdAt,
  });
  factory TourReviewModel.fromJson(Map<String, dynamic> json) => _$TourReviewModelFromJson(json);
  @JsonKey(name: 'review_id')
  final String? reviewId;

  @JsonKey(name: 'tour_id')
  final String? tourId;

  final ReviewUserModel? user;

  final double? rating;

  final String? text;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$TourReviewModelToJson(this);
}

@JsonSerializable()
@immutable
final class ReviewUserModel {
  const ReviewUserModel({
    this.id,
    this.fullName,
    this.imageUrl,
  });

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) => _$ReviewUserModelFromJson(json);

  final String? id;

  @JsonKey(name: 'full_name')
  final String? fullName;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  Map<String, dynamic> toJson() => _$ReviewUserModelToJson(this);
}
