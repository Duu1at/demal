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
  @JsonKey(fromJson: SortBy.fromString, toJson: _sortToJson)
  final SortBy? sortBy;

  ToursParams copyWith({
    String? search,
    String? location,
    String? tourType,
    String? dateFrom,
    String? dateTo,
    num? priceMin,
    num? priceMax,
    SortBy? sortBy,
  }) {
    return ToursParams(
      search: search ?? this.search,
      location: location ?? this.location,
      tourType: tourType ?? this.tourType,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMin ?? this.priceMin,
      sortBy: sortBy ?? this.sortBy,
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
