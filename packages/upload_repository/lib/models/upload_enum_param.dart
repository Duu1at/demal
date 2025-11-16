import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum UploadEnumParam {
  @JsonValue('image')
  image,
  @JsonValue('document')
  document,
}
