import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tours_model.g.dart';

@JsonSerializable()
@immutable
final class ToursModel {
  const ToursModel({this.success, this.tours, this.pagination});

  factory ToursModel.fromJson(Map<String, dynamic> json) => _$ToursModelFromJson(json);

  final bool? success;
  final List<TourModel>? tours;
  final PaginationModel? pagination;

  Map<String, dynamic> toJson() => _$ToursModelToJson(this);
}
