import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tour_model.g.dart';

@JsonSerializable()
@immutable
final class TourModel {
  const TourModel({
    this.tourId,
    this.title,
    this.mainImageUrl,
    this.location,
    this.tourType,
    this.date,
    this.time,
    this.price,
    this.currency,
    this.availableSpots,
    this.description,
    this.program,
    this.meetingPoint,
    this.whatsIncluded,
    this.whatsNotIncluded,
    this.whatToBring,
    this.imageGalleryUrls,
    this.organizer,
    this.status,
    this.averageRating,
    this.reviewsCount,
    this.createdAt,
    this.updatedAt,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) =>
      _$TourModelFromJson(json);

  @JsonKey(name: 'tour_id')
  final String? tourId;

  final String? title;

  @JsonKey(name: 'main_image_url')
  final String? mainImageUrl;

  final String? location;

  @JsonKey(name: 'tour_type')
  final String? tourType;

  final String? date;

  final String? time;

  final int? price;

  final String? currency;

  @JsonKey(name: 'available_spots')
  final int? availableSpots;

  final String? description;

  final Map<String, String>? program;

  @JsonKey(name: 'meeting_point')
  final MeetingPointModel? meetingPoint;

  @JsonKey(name: 'whats_included')
  final List<String>? whatsIncluded;

  @JsonKey(name: 'whats_not_included')
  final List<String>? whatsNotIncluded;

  @JsonKey(name: 'what_to_bring')
  final String? whatToBring;

  @JsonKey(name: 'image_gallery_urls')
  final List<String>? imageGalleryUrls;

  final OrganizerModel? organizer;

  final String? status;

  @JsonKey(name: 'average_rating')
  final double? averageRating;

  @JsonKey(name: 'reviews_count')
  final int? reviewsCount;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Map<String, dynamic> toJson() => _$TourModelToJson(this);
}