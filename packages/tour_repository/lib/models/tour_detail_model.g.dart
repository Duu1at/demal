// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourDetailModel _$TourDetailModelFromJson(Map<String, dynamic> json) => TourDetailModel(
  success: json['success'] as bool?,
  tour: json['tour'] == null ? null : TourModel.fromJson(json['tour'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TourDetailModelToJson(TourDetailModel instance) => <String, dynamic>{
  'success': instance.success,
  'tour': instance.tour,
};
