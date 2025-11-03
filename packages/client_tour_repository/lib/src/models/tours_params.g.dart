// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tours_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToursParams _$ToursParamsFromJson(Map<String, dynamic> json) => ToursParams(
  search: json['search'] as String?,
  location: json['location'] as String?,
  tourType: json['tour_type'] as String?,
  dateFrom: json['date_from'] as String?,
  dateTo: json['date_to'] as String?,
  priceMin: json['price_min'] as num?,
  priceMax: json['price_max'] as num?,
  sortBy: SortBy.fromString(json['sort_by'] as String?),
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$ToursParamsToJson(ToursParams instance) =>
    <String, dynamic>{
      'search': instance.search,
      'location': instance.location,
      'tour_type': instance.tourType,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
      'price_min': instance.priceMin,
      'price_max': instance.priceMax,
      'sort_by': ToursParams._sortToJson(instance.sortBy),
      'page': instance.page,
      'limit': instance.limit,
    };
