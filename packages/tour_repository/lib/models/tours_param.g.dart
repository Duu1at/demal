// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tours_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToursParam _$ToursParamFromJson(Map<String, dynamic> json) => ToursParam(
  search: json['search'] as String?,
  location: json['location'] as String?,
  tourType: json['tour_type'] as String?,
  dateFrom: json['date_from'] as String?,
  dateTo: json['date_to'] as String?,
  priceMin: json['price_min'] as num?,
  priceMax: json['price_max'] as num?,
  sortBy: $enumDecodeNullable(_$TourSortByEnumMap, json['sort_by']),
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$ToursParamToJson(ToursParam instance) => <String, dynamic>{
  'search': ?instance.search,
  'location': ?instance.location,
  'tour_type': ?instance.tourType,
  'date_from': ?instance.dateFrom,
  'date_to': ?instance.dateTo,
  'price_min': ?instance.priceMin,
  'price_max': ?instance.priceMax,
  'sort_by': ?_$TourSortByEnumMap[instance.sortBy],
  'page': ?instance.page,
  'limit': ?instance.limit,
};

const _$TourSortByEnumMap = {
  TourSortBy.dateAsc: 'date_asc',
  TourSortBy.dateDesc: 'date_desc',
  TourSortBy.priceAsc: 'price_asc',
  TourSortBy.priceDesc: 'price_desc',
  TourSortBy.ratingDesc: 'rating_desc',
};
