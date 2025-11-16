import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'create_tour_review_param.g.dart';

@JsonSerializable()
@immutable
class CreateTourReviewParam {
  const CreateTourReviewParam({
    required this.tourId,
    required this.rating,
    this.text,
  });

  factory CreateTourReviewParam.fromJson(Map<String, dynamic> json) => _$CreateTourReviewParamFromJson(json);

  @JsonKey(name: 'tour_id')
  final String tourId;

  final double rating;

  final String? text;

  Map<String, dynamic> toJson() => _$CreateTourReviewParamToJson(this);
}
