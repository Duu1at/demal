import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tour_update_param.g.dart';

@JsonSerializable(includeIfNull: false)
@immutable
final class TourUpdateParam {
  const TourUpdateParam({
    this.title,
    this.mainImageUrl,
    this.location,
    this.date,
    this.time,
    this.price,
    this.meetingPoint,
    this.tourType,
    this.availableSpots,
    this.whatsIncluded,
    this.whatsNotIncluded,
    this.imageGalleryUrls,
    this.currency,
    this.description,
    this.program,
    this.whatToBring,
  });
  factory TourUpdateParam.fromJson(Map<String, dynamic> json) => _$TourUpdateParamFromJson(json);

  final String? title;

  @JsonKey(name: 'main_image_url')
  final String? mainImageUrl;

  final String? location;

  @JsonKey(name: 'tour_type')
  final String? tourType;

  final String? date;

  final String? time;

  final double? price;

  final String? currency;

  @JsonKey(name: 'available_spots')
  final int? availableSpots;

  final String? description;

  final Map<String, String>? program;

  @JsonKey(name: 'meeting_point')
  final TourUpdateMeetingPoint? meetingPoint;

  @JsonKey(name: 'whats_included')
  final List<String>? whatsIncluded;

  @JsonKey(name: 'whats_not_included')
  final List<String>? whatsNotIncluded;

  @JsonKey(name: 'what_to_bring')
  final String? whatToBring;

  @JsonKey(name: 'image_gallery_urls')
  final List<String>? imageGalleryUrls;

  Map<String, dynamic> toJson() => _$TourUpdateParamToJson(this);
}

@JsonSerializable(includeIfNull: false)
@immutable
final class TourUpdateMeetingPoint {
  const TourUpdateMeetingPoint({
    this.address,
    this.coordinates,
  });
  factory TourUpdateMeetingPoint.fromJson(Map<String, dynamic> json) => _$TourUpdateMeetingPointFromJson(json);
  final String? address;
  final String? coordinates;

  Map<String, dynamic> toJson() => _$TourUpdateMeetingPointToJson(this);
}
