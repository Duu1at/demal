import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:upload_repository/upload_repository.dart';

part 'upload_single_model.g.dart';

@JsonSerializable()
@immutable
final class UploadSingleModel {
  const UploadSingleModel({
    required this.success,
    required this.data,
  });
  factory UploadSingleModel.fromJson(Map<String, dynamic> json) => _$UploadSingleModelFromJson(json);
  final bool success;
  final UploadDataModel data;

  Map<String, dynamic> toJson() => _$UploadSingleModelToJson(this);
}
