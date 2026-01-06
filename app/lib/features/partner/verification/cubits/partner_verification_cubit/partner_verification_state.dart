part of 'partner_verification_cubit.dart';

@immutable
final class PartnerVerificationState extends Equatable {
  const PartnerVerificationState({
    this.companyName = '',
    this.description = '',
    this.cardNumber = '',
    this.documentUrl,
    this.isTermsAccepted = false,
    this.requestStatus = const RequestInitial(),
    this.isUploadingDocument = false,
  });

  final String companyName;
  final String description;
  final String cardNumber;
  final String? documentUrl;
  final bool isTermsAccepted;
  final RequestStatus<void> requestStatus;
  final bool isUploadingDocument;

  bool get isValid {
    return companyName.isNotEmpty &&
        description.isNotEmpty &&
        cardNumber.length >= 16 &&
        documentUrl != null &&
        isTermsAccepted;
  }

  PartnerVerificationState copyWith({
    String? companyName,
    String? description,
    String? cardNumber,
    String? documentUrl,
    bool? isTermsAccepted,
    RequestStatus<void>? requestStatus,
    bool? isUploadingDocument,
    bool removeDocumentUrl = false,
  }) {
    return PartnerVerificationState(
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      cardNumber: cardNumber ?? this.cardNumber,
      documentUrl: removeDocumentUrl ? null : (documentUrl ?? this.documentUrl),
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      requestStatus: requestStatus ?? this.requestStatus,
      isUploadingDocument: isUploadingDocument ?? this.isUploadingDocument,
    );
  }

  @override
  List<Object?> get props => [
    companyName,
    description,
    cardNumber,
    documentUrl,
    isTermsAccepted,
    requestStatus,
    isUploadingDocument,
  ];
}
