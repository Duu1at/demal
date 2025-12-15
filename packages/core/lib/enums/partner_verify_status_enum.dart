import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum PartnerVerifyStatusEnum {
  @JsonValue('NOT_STARTED')
  notStarted,
  @JsonValue('PENDING')
  pending,
  @JsonValue('VERIFIED')
  verified,
  @JsonValue('REJECTED')
  rejected,
}
