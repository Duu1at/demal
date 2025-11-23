part of 'partner_verification_bloc.dart';

sealed class PartnerVerificationEvent extends Equatable {
  const PartnerVerificationEvent();

  @override
  List<Object?> get props => [];
}

final class PartnerVerificationStatusChecked extends PartnerVerificationEvent {
  const PartnerVerificationStatusChecked();
}

final class PartnerVerificationFormSubmitted extends PartnerVerificationEvent {
  const PartnerVerificationFormSubmitted();
}

final class PartnerVerificationDocumentSelected extends PartnerVerificationEvent {
  const PartnerVerificationDocumentSelected(this.file);

  final File file;

  @override
  List<Object?> get props => [file];
}

final class PartnerVerificationProfileImageSelected
    extends PartnerVerificationEvent {
  const PartnerVerificationProfileImageSelected(this.file);

  final File file;

  @override
  List<Object?> get props => [file];
}

final class PartnerVerificationFormChanged extends PartnerVerificationEvent {
  const PartnerVerificationFormChanged({
    this.companyName,
    this.description,
    this.cardNumber,
    this.agreedToTerms,
  });

  final String? companyName;
  final String? description;
  final String? cardNumber;
  final bool? agreedToTerms;

  @override
  List<Object?> get props => [companyName, description, cardNumber, agreedToTerms];
}
