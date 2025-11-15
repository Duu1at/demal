// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_create_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourCreateParam _$TourCreateParamFromJson(Map<String, dynamic> json) => TourCreateParam(
  title: json['title'] as String,
  mainImageUrl: json['main_image_url'] as String,
  location: json['location'] as String,
  date: json['date'] as String,
  time: json['time'] as String,
  price: (json['price'] as num).toDouble(),
  meetingPoint: json['meeting_point'] == null
      ? null
      : MeetingPoint.fromJson(
          json['meeting_point'] as Map<String, dynamic>,
        ),
  tourType: json['tour_type'] as String?,
  availableSpots: (json['available_spots'] as num?)?.toInt(),
  whatsIncluded: (json['whats_included'] as List<dynamic>?)?.map((e) => e as String).toList(),
  whatsNotIncluded: (json['whats_not_included'] as List<dynamic>?)?.map((e) => e as String).toList(),
  imageGalleryUrls: (json['image_gallery_urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
  currency: json['currency'] as String?,
  description: json['description'] as String?,
  program: (json['program'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  whatToBring: json['what_to_bring'] as String?,
);

Map<String, dynamic> _$TourCreateParamToJson(TourCreateParam instance) => <String, dynamic>{
  'title': instance.title,
  'main_image_url': instance.mainImageUrl,
  'location': instance.location,
  'tour_type': instance.tourType,
  'date': instance.date,
  'time': instance.time,
  'price': instance.price,
  'currency': instance.currency,
  'available_spots': instance.availableSpots,
  'description': instance.description,
  'program': instance.program,
  'meeting_point': instance.meetingPoint,
  'whats_included': instance.whatsIncluded,
  'whats_not_included': instance.whatsNotIncluded,
  'what_to_bring': instance.whatToBring,
  'image_gallery_urls': instance.imageGalleryUrls,
};

MeetingPoint _$MeetingPointFromJson(Map<String, dynamic> json) => MeetingPoint(
  address: json['address'] as String,
  coordinates: json['coordinates'] as String?,
);

Map<String, dynamic> _$MeetingPointToJson(MeetingPoint instance) => <String, dynamic>{
  'address': instance.address,
  'coordinates': instance.coordinates,
};
