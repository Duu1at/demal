import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
@immutable
final class PaginationModel {
  const PaginationModel({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);

  final int page;

  final int limit;

  @JsonKey(name: 'total_items')
  final int totalItems;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
