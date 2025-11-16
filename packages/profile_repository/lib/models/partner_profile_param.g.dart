// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_profile_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerProfileParam _$PartnerProfileParamFromJson(Map<String, dynamic> json) => PartnerProfileParam(
  companyName: json['company_name'] as String,
  description: json['description'] as String,
  documentsUrl: json['documents_url'] as String,
  cardNumber: json['card_number'] as String,
);

Map<String, dynamic> _$PartnerProfileParamToJson(
  PartnerProfileParam instance,
) => <String, dynamic>{
  'company_name': instance.companyName,
  'description': instance.description,
  'documents_url': instance.documentsUrl,
  'card_number': instance.cardNumber,
};
