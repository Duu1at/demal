import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tour_detail_model.g.dart';

@JsonSerializable()
@immutable
final class TourDetailModel {
  const TourDetailModel({this.success, this.tour});

  factory TourDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TourDetailModelFromJson(json);

  final bool? success;
  final TourModel? tour;

  Map<String, dynamic> toJson() => _$TourDetailModelToJson(this);
}
