import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'name')
enum RoleEnum {
  @JsonValue('ADMIN')
  admin,
  @JsonValue('PARTNER')
  partner,
  @JsonValue('CLIENT')
  client,
  @JsonValue('')
  unknown,
}
