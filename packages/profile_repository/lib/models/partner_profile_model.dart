import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

part 'partner_profile_model.g.dart';

@JsonSerializable()
@immutable
final class PartnerProfileModel {
  const PartnerProfileModel({
    required this.success,
    required this.profile,
  });

  factory PartnerProfileModel.fromJson(Map<String, dynamic> json) => _$PartnerProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerProfileModelToJson(this);

  final bool success;
  final PartnerProfileSubModel profile;
}

@JsonSerializable()
@immutable
final class PartnerProfileSubModel {
  const PartnerProfileSubModel({
    this.profileId,
    this.userId,
    this.companyName,
    this.description,
    this.documentsUrl,
    this.verificationStatus,
    this.cardNumber,
  });

  factory PartnerProfileSubModel.fromJson(Map<String, dynamic> json) => _$PartnerProfileSubModelFromJson(json);

  @JsonKey(name: 'profile_id')
  final String? profileId;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'company_name')
  final String? companyName;

  final String? description;

  @JsonKey(name: 'documents_url')
  final String? documentsUrl;

  @JsonKey(name: 'verification_status')
  final PartnerVerifyStatusEnum? verificationStatus;

  @JsonKey(name: 'card_number')
  final String? cardNumber;

  Map<String, dynamic> toJson() => _$PartnerProfileSubModelToJson(this);
}
