import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'partner_profile_param.g.dart';

@JsonSerializable()
@immutable
final class PartnerProfileParam {
  const PartnerProfileParam({
    required this.companyName,
    required this.description,
    required this.documentsUrl,
    required this.cardNumber,
  });

  factory PartnerProfileParam.fromJson(Map<String, dynamic> json) => _$PartnerProfileParamFromJson(json);

  @JsonKey(name: 'company_name')
  final String companyName;

  final String description;

  @JsonKey(name: 'documents_url')
  final String documentsUrl;

  @JsonKey(name: 'card_number')
  final String cardNumber;

  Map<String, dynamic> toJson() => _$PartnerProfileParamToJson(this);
}
