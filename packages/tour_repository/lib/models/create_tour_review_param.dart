import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'create_tour_review_param.g.dart';

@JsonSerializable()
@immutable
class CreateTourReviewParam {
  const CreateTourReviewParam({
    required this.tourId,
    required this.text,
    this.rating = 0,
  });

  factory CreateTourReviewParam.fromJson(Map<String, dynamic> json) => _$CreateTourReviewParamFromJson(json);

  @JsonKey(name: 'tour_id')
  final String tourId;

  @JsonKey(name: 'rating', defaultValue: 0)
  final num rating;

  @JsonKey(name: 'text')
  final String text;

  Map<String, dynamic> toJson() => _$CreateTourReviewParamToJson(this);
}
