import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:upload_repository/upload_repository.dart';

part 'upload_multiple_model.g.dart';

@JsonSerializable()
@immutable
final class UploadMultipleModel {
  const UploadMultipleModel({
    required this.success,
    required this.data,
  });
  factory UploadMultipleModel.fromJson(Map<String, dynamic> json) => _$UploadMultipleModelFromJson(json);
  final bool success;
  final List<UploadDataModel> data;

  Map<String, dynamic> toJson() => _$UploadMultipleModelToJson(this);
}
