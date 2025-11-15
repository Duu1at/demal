// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_update_profile_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerUpdateProfileParam _$PartnerUpdateProfileParamFromJson(
  Map<String, dynamic> json,
) => PartnerUpdateProfileParam(
  companyName: json['company_name'] as String,
  description: json['description'] as String,
  documentsUrl: json['documents_url'] as String,
  cardNumber: json['card_number'] as String,
);

Map<String, dynamic> _$PartnerUpdateProfileParamToJson(
  PartnerUpdateProfileParam instance,
) => <String, dynamic>{
  'company_name': instance.companyName,
  'description': instance.description,
  'documents_url': instance.documentsUrl,
  'card_number': instance.cardNumber,
};
