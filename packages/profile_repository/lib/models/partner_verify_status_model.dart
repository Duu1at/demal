import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

part 'partner_verify_status_model.g.dart';

@JsonSerializable()
@immutable
final class PartnerVerifyStatusModel extends Equatable {
  const PartnerVerifyStatusModel({
    this.success,
    this.verificationStatus,
    this.adminComments,
    this.submittedAt,
    this.reviewedAt,
  });

  factory PartnerVerifyStatusModel.fromJson(Map<String, dynamic> json) => _$PartnerVerifyStatusModelFromJson(json);

  final bool? success;

  @JsonKey(name: 'verification_status')
  final PartnerVerifyStatusEnum? verificationStatus;

  @JsonKey(name: 'admin_comments')
  final String? adminComments;

  @JsonKey(name: 'submitted_at')
  final DateTime? submittedAt;

  @JsonKey(name: 'reviewed_at')
  final DateTime? reviewedAt;

  Map<String, dynamic> toJson() => _$PartnerVerifyStatusModelToJson(this);

  @override
  List<Object?> get props => [success, verificationStatus, adminComments, submittedAt, reviewedAt];
}
