import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

part 'tours_reviews_model.g.dart';

@JsonSerializable()
@immutable
final class ToursReviewsModel {
  const ToursReviewsModel({
    this.success,
    this.reviews,
    this.pagination,
  });
  factory ToursReviewsModel.fromJson(Map<String, dynamic> json) => _$ToursReviewsModelFromJson(json);
  final bool? success;
  final List<TourReviewModel>? reviews;
  final PaginationModel? pagination;

  Map<String, dynamic> toJson() => _$ToursReviewsModelToJson(this);
}
