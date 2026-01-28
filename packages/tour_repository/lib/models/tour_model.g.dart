// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourModel _$TourModelFromJson(Map<String, dynamic> json) => TourModel(
  tourId: json['tour_id'] as String?,
  title: json['title'] as String?,
  mainImageUrl: json['main_image_url'] as String?,
  location: json['location'] as String?,
  tourType: json['tour_type'] as String?,
  date: json['date'] as String?,
  time: json['time'] as String?,
  price: (json['price'] as num?)?.toInt(),
  currency: $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
  availableSpots: (json['available_spots'] as num?)?.toInt(),
  description: json['description'] as String?,
  program: (_emptyListToNull(json, 'program') as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  meetingPoint: _emptyListToNull(json, 'meeting_point') == null
      ? null
      : MeetingPointModel.fromJson(
          _emptyListToNull(json, 'meeting_point') as Map<String, dynamic>,
        ),
  whatsIncluded: (json['whats_included'] as List<dynamic>?)?.map((e) => e as String).toList(),
  whatsNotIncluded: (json['whats_not_included'] as List<dynamic>?)?.map((e) => e as String).toList(),
  whatToBring: json['what_to_bring'] as String?,
  imageGalleryUrls: (json['image_gallery_urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
  organizer: _emptyListToNull(json, 'organizer') == null
      ? null
      : OrganizerModel.fromJson(
          _emptyListToNull(json, 'organizer') as Map<String, dynamic>,
        ),
  status: json['status'] as String?,
  averageRating: (json['average_rating'] as num?)?.toDouble(),
  reviewsCount: (json['reviews_count'] as num?)?.toInt(),
  createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TourModelToJson(TourModel instance) => <String, dynamic>{
  'tour_id': instance.tourId,
  'title': instance.title,
  'main_image_url': instance.mainImageUrl,
  'location': instance.location,
  'tour_type': instance.tourType,
  'date': instance.date,
  'time': instance.time,
  'price': instance.price,
  'currency': _$CurrencyEnumMap[instance.currency],
  'available_spots': instance.availableSpots,
  'description': instance.description,
  'program': instance.program,
  'meeting_point': instance.meetingPoint,
  'whats_included': instance.whatsIncluded,
  'whats_not_included': instance.whatsNotIncluded,
  'what_to_bring': instance.whatToBring,
  'image_gallery_urls': instance.imageGalleryUrls,
  'organizer': instance.organizer,
  'status': instance.status,
  'average_rating': instance.averageRating,
  'reviews_count': instance.reviewsCount,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$CurrencyEnumMap = {
  Currency.KGS: 'KGS',
  Currency.USD: 'USD',
  Currency.RUB: 'RUB',
};
