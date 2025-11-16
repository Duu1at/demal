import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum RoleEnum {
  @JsonValue('ADMIN')
  ADMIN,
  @JsonValue('PARTNER')
  PARTNER,
  @JsonValue('CLIENT')
  CLIENT,
  @JsonValue('')
  UNKNOWN,
}
