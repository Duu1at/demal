import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tour_create_param.g.dart';

@JsonSerializable()
@immutable
final class TourCreateParam {
  const TourCreateParam({
    required this.title,
    required this.mainImageUrl,
    required this.location,
    required this.date,
    required this.time,
    required this.price,
    required this.meetingPoint,
    required this.tourType,
    required this.availableSpots,
    required this.whatsIncluded,
    required this.whatsNotIncluded,
    required this.imageGalleryUrls,
    this.currency,
    this.description,
    this.program,
    this.whatToBring,
  });
  factory TourCreateParam.fromJson(Map<String, dynamic> json) => _$TourCreateParamFromJson(json);

  final String title;

  @JsonKey(name: 'main_image_url')
  final String mainImageUrl;

  final String location;

  @JsonKey(name: 'tour_type')
  final String? tourType;

  final String date;

  final String time;

  final int price;

  final String? currency;

  @JsonKey(name: 'available_spots')
  final int? availableSpots;

  final String? description;

  final Map<String, String>? program;

  @JsonKey(name: 'meeting_point')
  final MeetingPoint? meetingPoint;

  @JsonKey(name: 'whats_included')
  final List<String>? whatsIncluded;

  @JsonKey(name: 'whats_not_included')
  final List<String>? whatsNotIncluded;

  @JsonKey(name: 'what_to_bring')
  final String? whatToBring;

  @JsonKey(name: 'image_gallery_urls')
  final List<String>? imageGalleryUrls;

  Map<String, dynamic> toJson() => _$TourCreateParamToJson(this);
}

@JsonSerializable()
@immutable
final class MeetingPoint {
  const MeetingPoint({
    required this.address,
    this.coordinates,
  });
  factory MeetingPoint.fromJson(Map<String, dynamic> json) => _$MeetingPointFromJson(json);
  final String address;
  final String? coordinates;

  Map<String, dynamic> toJson() => _$MeetingPointToJson(this);
}
