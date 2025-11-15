// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerProfileModel _$PartnerProfileModelFromJson(Map<String, dynamic> json) => PartnerProfileModel(
  success: json['success'] as bool,
  profile: PartnerProfileSubModel.fromJson(
    json['profile'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PartnerProfileModelToJson(
  PartnerProfileModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'profile': instance.profile,
};

PartnerProfileSubModel _$PartnerProfileSubModelFromJson(
  Map<String, dynamic> json,
) => PartnerProfileSubModel(
  profileId: json['profile_id'] as String?,
  userId: json['user_id'] as String?,
  companyName: json['company_name'] as String?,
  description: json['description'] as String?,
  documentsUrl: json['documents_url'] as String?,
  verificationStatus: $enumDecodeNullable(
    _$PartnerVerifyStatusEnumEnumMap,
    json['verification_status'],
  ),
  cardNumber: json['card_number'] as String?,
);

Map<String, dynamic> _$PartnerProfileSubModelToJson(
  PartnerProfileSubModel instance,
) => <String, dynamic>{
  'profile_id': instance.profileId,
  'user_id': instance.userId,
  'company_name': instance.companyName,
  'description': instance.description,
  'documents_url': instance.documentsUrl,
  'verification_status': _$PartnerVerifyStatusEnumEnumMap[instance.verificationStatus],
  'card_number': instance.cardNumber,
};

const _$PartnerVerifyStatusEnumEnumMap = {
  PartnerVerifyStatusEnum.pending: 'PENDING',
  PartnerVerifyStatusEnum.verified: 'VERIFIED',
  PartnerVerifyStatusEnum.rejected: 'REJECTED',
};
