import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

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
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;
}
