import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tours_param.g.dart';

@JsonSerializable(includeIfNull: false)
@immutable
final class ToursParam {
  const ToursParam({
    this.search,
    this.location,
    this.tourType,
    this.dateFrom,
    this.dateTo,
    this.priceMin,
    this.priceMax,
    this.sortBy,
    this.page,
    this.limit,
  });

  factory ToursParam.fromJson(Map<String, dynamic> json) => _$ToursParamFromJson(json);

  final String? search;

  final String? location;

  @JsonKey(name: 'tour_type')
  final String? tourType;

  @JsonKey(name: 'date_from')
  final String? dateFrom;

  @JsonKey(name: 'date_to')
  final String? dateTo;

  @JsonKey(name: 'price_min')
  final num? priceMin;

  @JsonKey(name: 'price_max')
  final num? priceMax;

  @JsonKey(name: 'sort_by')
  final TourSortBy? sortBy;

  final int? page;
  final int? limit;

  ToursParam copyWith({
    String? search,
    String? location,
    String? tourType,
    String? dateFrom,
    String? dateTo,
    num? priceMin,
    num? priceMax,
    TourSortBy? sortBy,
    int? page,
    int? limit,
  }) {
    return ToursParam(
      search: search ?? this.search,
      location: location ?? this.location,
      tourType: tourType ?? this.tourType,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      sortBy: sortBy ?? this.sortBy,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toJson() => _$ToursParamToJson(this);

  bool get isEmpty =>
      search == null &&
      location == null &&
      tourType == null &&
      dateFrom == null &&
      dateTo == null &&
      priceMin == null &&
      priceMax == null &&
      sortBy == null &&
      page == null &&
      limit == null;
}

@JsonEnum()
enum TourSortBy {
  @JsonValue('date_asc')
  dateAsc,
  @JsonValue('date_desc')
  dateDesc,
  @JsonValue('price_asc')
  priceAsc,
  @JsonValue('price_desc')
  priceDesc,
  @JsonValue('rating_desc')
  ratingDesc,
}
