import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'pagination_model.g.dart';

abstract class PaginationModel<T> {
  const PaginationModel({
    this.success,
    this.pagination,
  });

  final bool? success;
  final PaginationResponseModel? pagination;

  List<T> get items;
  PaginationInfo? get paginationInfo => pagination?.toPaginationInfo();
}

@JsonSerializable()
@immutable
final class PaginationResponseModel {
  const PaginationResponseModel({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginationResponseModel.fromJson(Map<String, dynamic> json) => _$PaginationResponseModelFromJson(json);

  final int page;

  final int limit;

  @JsonKey(name: 'total_items')
  final int totalItems;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  Map<String, dynamic> toJson() => _$PaginationResponseModelToJson(this);

  PaginationInfo toPaginationInfo() => PaginationInfo(
    page: page,
    limit: limit,
    totalItems: totalItems,
    totalPages: totalPages,
  );
}

@immutable
final class PaginationInfo {
  const PaginationInfo({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
  });

  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;
}
