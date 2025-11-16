// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_verify_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerVerifyStatusModel _$PartnerVerifyStatusModelFromJson(
  Map<String, dynamic> json,
) => PartnerVerifyStatusModel(
  success: json['success'] as bool?,
  verificationStatus: $enumDecodeNullable(
    _$PartnerVerifyStatusEnumEnumMap,
    json['verification_status'],
  ),
  adminComments: json['admin_comments'] as String?,
  submittedAt: json['submitted_at'] == null ? null : DateTime.parse(json['submitted_at'] as String),
  reviewedAt: json['reviewed_at'] == null ? null : DateTime.parse(json['reviewed_at'] as String),
);

Map<String, dynamic> _$PartnerVerifyStatusModelToJson(
  PartnerVerifyStatusModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'verification_status': _$PartnerVerifyStatusEnumEnumMap[instance.verificationStatus],
  'admin_comments': instance.adminComments,
  'submitted_at': instance.submittedAt?.toIso8601String(),
  'reviewed_at': instance.reviewedAt?.toIso8601String(),
};

const _$PartnerVerifyStatusEnumEnumMap = {
  PartnerVerifyStatusEnum.pending: 'PENDING',
  PartnerVerifyStatusEnum.verified: 'VERIFIED',
  PartnerVerifyStatusEnum.rejected: 'REJECTED',
};
