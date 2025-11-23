part of 'partner_verification_bloc.dart';

enum PartnerVerificationStatus {
  initial,
  loading,
  loaded,
  submitting,
  submitted,
  error,
  validationError,
}

final class PartnerVerificationState extends Equatable {
  const PartnerVerificationState({
    required this.status,
    this.verificationStatus,
    this.adminComments,
    this.companyName = '',
    this.description = '',
    this.cardNumber = '',
    this.agreedToTerms = false,
    this.documentFile,
    this.documentUrl,
    this.profileImageFile,
    this.profileImageUrl,
    this.error,
  });

  const PartnerVerificationState.initial()
      : status = PartnerVerificationStatus.initial,
        verificationStatus = null,
        adminComments = null,
        companyName = '',
        description = '',
        cardNumber = '',
        agreedToTerms = false,
        documentFile = null,
        documentUrl = null,
        profileImageFile = null,
        profileImageUrl = null,
        error = null;

  final PartnerVerificationStatus status;
  final PartnerVerifyStatusEnum? verificationStatus;
  final String? adminComments;
  final String companyName;
  final String description;
  final String cardNumber;
  final bool agreedToTerms;
  final File? documentFile;
  final String? documentUrl;
  final File? profileImageFile;
  final String? profileImageUrl;
  final String? error;

  bool get isFormValid {
    return companyName.isNotEmpty &&
        description.isNotEmpty &&
        cardNumber.isNotEmpty &&
        agreedToTerms &&
        (documentFile != null || documentUrl != null);
  }

  bool get isVerified {
    return verificationStatus == PartnerVerifyStatusEnum.verified;
  }

  bool get isPending {
    return verificationStatus == PartnerVerifyStatusEnum.pending;
  }

  bool get isRejected {
    return verificationStatus == PartnerVerifyStatusEnum.rejected;
  }

  PartnerVerificationState copyWith({
    PartnerVerificationStatus? status,
    PartnerVerifyStatusEnum? verificationStatus,
    String? adminComments,
    String? companyName,
    String? description,
    String? cardNumber,
    bool? agreedToTerms,
    File? documentFile,
    String? documentUrl,
    File? profileImageFile,
    String? profileImageUrl,
    String? error,
  }) {
    return PartnerVerificationState(
      status: status ?? this.status,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      adminComments: adminComments ?? this.adminComments,
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      cardNumber: cardNumber ?? this.cardNumber,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
      documentFile: documentFile ?? this.documentFile,
      documentUrl: documentUrl ?? this.documentUrl,
      profileImageFile: profileImageFile ?? this.profileImageFile,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        verificationStatus,
        adminComments,
        companyName,
        description,
        cardNumber,
        agreedToTerms,
        documentFile,
        documentUrl,
        profileImageFile,
        profileImageUrl,
        error,
      ];
}
