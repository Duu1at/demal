import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

part 'tours_reviews_model.g.dart';

@JsonSerializable()
@immutable
final class ToursReviewsModel extends PaginationModel<TourReviewModel> {
  const ToursReviewsModel({
    this.reviews,
    super.success,
    super.pagination,
  });
  factory ToursReviewsModel.fromJson(Map<String, dynamic> json) => _$ToursReviewsModelFromJson(json);
  final List<TourReviewModel>? reviews;

  @override
  List<TourReviewModel> get items => reviews ?? [];

  Map<String, dynamic> toJson() => _$ToursReviewsModelToJson(this);
}
