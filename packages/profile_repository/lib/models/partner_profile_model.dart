import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

part 'partner_profile_model.g.dart';

@JsonSerializable()
@immutable
final class PartnerProfileModel {
  const PartnerProfileModel({
    this.profileId,
    this.companyName,
    this.description,
    this.documentsUrl,
    this.verificationStatus,
    this.cardNumber,
  });

  factory PartnerProfileModel.fromJson(Map<String, dynamic> json) => _$PartnerProfileModelFromJson(json);

  @JsonKey(name: 'profile_id')
  final String? profileId;
  @JsonKey(name: 'company_name')
  final String? companyName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'documents_url')
  final String? documentsUrl;
  @JsonKey(name: 'verification_status')
  final PartnerVerifyStatusEnum? verificationStatus;
  @JsonKey(name: 'card_number')
  final String? cardNumber;

  Map<String, dynamic> toJson() => _$PartnerProfileModelToJson(this);
}
