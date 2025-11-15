import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'partner_update_profile_param.g.dart';

@JsonSerializable()
@immutable
final class PartnerUpdateProfileParam {
  const PartnerUpdateProfileParam({
    required this.companyName,
    required this.description,
    required this.documentsUrl,
    required this.cardNumber,
  });

  factory PartnerUpdateProfileParam.fromJson(Map<String, dynamic> json) => _$PartnerUpdateProfileParamFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerUpdateProfileParamToJson(this);

  @JsonKey(name: 'company_name')
  final String companyName;
  final String description;

  @JsonKey(name: 'documents_url')
  final String documentsUrl;

  @JsonKey(name: 'card_number')
  final String cardNumber;
}
