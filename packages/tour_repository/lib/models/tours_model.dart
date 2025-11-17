import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

part 'tours_model.g.dart';

@JsonSerializable()
@immutable
final class ToursModel extends PaginationModel<TourModel> {
  const ToursModel({
    this.tours,
    super.success,
    super.pagination,
  });

  factory ToursModel.fromJson(Map<String, dynamic> json) => _$ToursModelFromJson(json);

  final List<TourModel>? tours;

  @override
  List<TourModel> get items => tours ?? [];

  Map<String, dynamic> toJson() => _$ToursModelToJson(this);
}
