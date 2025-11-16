import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum PartnerVerifyStatusEnum {
  @JsonValue('PENDING')
  pending,
  @JsonValue('VERIFIED')
  verified,
  @JsonValue('REJECTED')
  rejected,
}
