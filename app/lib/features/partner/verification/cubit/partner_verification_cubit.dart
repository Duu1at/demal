import 'dart:io';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:upload_repository/upload_repository.dart';

part 'partner_verification_state.dart';

class PartnerVerificationCubit extends Cubit<PartnerVerificationState> {
  PartnerVerificationCubit({
    required this.profileRepository,
    required this.uploadRepository,
  }) : super(const PartnerVerificationState());

  final ProfileRepository profileRepository;
  final UploadRepository uploadRepository;

  void updateCompanyName(String value) {
    emit(state.copyWith(companyName: value));
  }

  void updateDescription(String value) {
    emit(state.copyWith(description: value));
  }

  void updateCardNumber(String value) {
    emit(state.copyWith(cardNumber: value));
  }

  void toggleTermsAccepted() {
    emit(state.copyWith(isTermsAccepted: !state.isTermsAccepted));
  }

  Future<void> pickAndUploadDocument(BuildContext context) async {
    try {
      emit(state.copyWith(isUploadingDocument: true));
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result == null || result.files.isEmpty || result.files.single.path == null) {
        emit(state.copyWith(isUploadingDocument: false));
        return;
      }

      final file = File(result.files.single.path!);
      final uploadResult = await uploadRepository.uploadSingleFile(
        UploadEnumParam.document,
        file,
      );

      final url = uploadResult.data.url;
      debugPrint(url);
      if (url != null && url.isNotEmpty) {
        emit(
          state.copyWith(
            documentUrl: url,
            isUploadingDocument: false,
          ),
        );
      } else {
        emit(state.copyWith(isUploadingDocument: false));
      }
    } on Object catch (_) {
      emit(state.copyWith(isUploadingDocument: false));
    }
  }

  void removeDocument() {
    emit(state.copyWith(removeDocumentUrl: true));
  }

  Future<void> submitVerification() async {
    if (!state.isValid) return;

    try {
      emit(state.copyWith(requestStatus: RequestLoading()));

      await profileRepository.updatePartnerProfile(
        PartnerProfileParam(
          companyName: state.companyName.trim(),
          description: state.description.trim(),
          cardNumber: state.cardNumber.replaceAll(' ', ''),
          documentsUrl: state.documentUrl ?? '',
        ),
      );
      await profileRepository.getProfile();

      emit(state.copyWith(requestStatus: const RequestSuccess(null)));
    } on Object catch (e) {
      emit(state.copyWith(requestStatus: RequestFailure(e)));
    }
  }
}
