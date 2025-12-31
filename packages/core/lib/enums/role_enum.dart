import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum RoleEnum {
  @JsonValue('PARTNER')
  PARTNER,
  @JsonValue('CLIENT')
  CLIENT,
  @JsonValue('')
  GUEST,
}
