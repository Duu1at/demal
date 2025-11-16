import 'package:bookings_repository/bookings_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'my_bookings_model.g.dart';

@JsonSerializable()
@immutable
final class MyBookingsModel {
  const MyBookingsModel({
    required this.success,
    required this.bookings,
    required this.pagination,
  });

  factory MyBookingsModel.fromJson(Map<String, dynamic> json) => _$MyBookingsModelFromJson(json);

  final bool success;
  final List<BookingModel> bookings;
  final PaginationModel? pagination;
  Map<String, dynamic> toJson() => _$MyBookingsModelToJson(this);
}

@JsonSerializable()
@immutable
final class PaginationModel {
  const PaginationModel({
    this.page,
    this.limit,
    this.totalItems,
    this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
  final int? page;
  final int? limit;

  @JsonKey(name: 'total_items')
  final int? totalItems;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
}
