part of 'partner_verification_cubit.dart';

@immutable
final class PartnerVerificationState {
  const PartnerVerificationState({
    this.companyName = '',
    this.description = '',
    this.cardNumber = '',
    this.avatarUrl,
    this.documentUrls = const [],
    this.isTermsAccepted = false,
    this.isLoading = false,
    this.isSubmitting = false,
    this.isUploadingDocuments = false,
    this.isSuccess = false,
    this.error,
  });
  final String companyName;
  final String description;
  final String cardNumber;
  final String? avatarUrl;
  final List<String> documentUrls;
  final bool isTermsAccepted;
  final bool isLoading;
  final bool isSubmitting;
  final bool isUploadingDocuments;
  final bool isSuccess;
  final Object? error;

  PartnerVerificationState copyWith({
    String? companyName,
    String? description,
    String? cardNumber,
    String? avatarUrl,
    List<String>? documentUrls,
    bool? isTermsAccepted,
    bool? isLoading,
    bool? isSubmitting,
    bool? isUploadingDocuments,
    bool? isSuccess,
    Object? error,
  }) {
    return PartnerVerificationState(
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      cardNumber: cardNumber ?? this.cardNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      documentUrls: documentUrls ?? this.documentUrls,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isUploadingDocuments: isUploadingDocuments ?? this.isUploadingDocuments,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}
