import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tours_params.g.dart';

@JsonSerializable()
@immutable
final class ToursParams {
  const ToursParams({
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

  factory ToursParams.fromJson(Map<String, dynamic> json) =>
      _$ToursParamsFromJson(json);

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

  static String? _sortToJson(SortBy? sortBy) => sortBy?.toJson();
  @JsonKey(name: 'sort_by', fromJson: SortBy.fromString, toJson: _sortToJson)
  final SortBy? sortBy;

  final int? page;
  final int? limit;

  ToursParams copyWith({
    String? search,
    String? location,
    String? tourType,
    String? dateFrom,
    String? dateTo,
    num? priceMin,
    num? priceMax,
    SortBy? sortBy,
    int? page,
    int? limit,
    bool clearSearch = false,
    bool clearLocation = false,
    bool clearTourType = false,
    bool clearDateFrom = false,
    bool clearDateTo = false,
    bool clearPriceMin = false,
    bool clearPriceMax = false,
    bool clearSortBy = false,
    bool clearPage = false,
    bool clearLimit = false,
  }) {
    return ToursParams(
      search: clearSearch ? null : (search ?? this.search),
      location: clearLocation ? null : (location ?? this.location),
      tourType: clearTourType ? null : (tourType ?? this.tourType),
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      priceMin: clearPriceMin ? null : (priceMin ?? this.priceMin),
      priceMax: clearPriceMax ? null : (priceMax ?? this.priceMax),
      sortBy: clearSortBy ? null : (sortBy ?? this.sortBy),
      page: clearPage ? null : (page ?? this.page),
      limit: clearLimit ? null : (limit ?? this.limit),
    );
  }

  Map<String, dynamic> toJson() => _$ToursParamsToJson(this);
}

enum SortBy {
  dateAsc,
  dateDesc,
  priceAsc,
  priceDesc,
  ratingDesc;

  static SortBy? fromString(String? value) {
    switch (value) {
      case 'date_asc':
        return SortBy.dateAsc;
      case 'date_desc':
        return SortBy.dateDesc;
      case 'price_asc':
        return SortBy.priceAsc;
      case 'price_desc':
        return SortBy.priceDesc;
      case 'rating_desc':
        return SortBy.ratingDesc;
      default:
        return null;
    }
  }

  String? toJson() {
    switch (this) {
      case SortBy.dateAsc:
        return 'date_asc';
      case SortBy.dateDesc:
        return 'date_desc';
      case SortBy.priceAsc:
        return 'price_asc';
      case SortBy.priceDesc:
        return 'price_desc';
      case SortBy.ratingDesc:
        return 'rating_desc';
    }
  }
}
