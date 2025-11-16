import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'upload_data_model.g.dart';

@JsonSerializable()
@immutable
final class UploadDataModel {
  const UploadDataModel({
    this.url,
  });

  factory UploadDataModel.fromJson(Map<String, dynamic> json) => _$UploadDataModelFromJson(json);
  final String? url;

  Map<String, dynamic> toJson() => _$UploadDataModelToJson(this);
}
