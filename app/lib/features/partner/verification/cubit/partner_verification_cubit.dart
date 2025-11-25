import 'dart:io';

import 'package:app/utils/image_picker_service/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:upload_repository/upload_repository.dart';

part 'partner_verification_state.dart';

class PartnerVerificationCubit extends Cubit<PartnerVerificationState> {
  PartnerVerificationCubit({
    required this.profileRepository,
    required this.uploadRepository,
    required this.imagePickerService,
  }) : super(const PartnerVerificationState());

  final ProfileRepository profileRepository;
  final UploadRepository uploadRepository;
  final ImagePickerService imagePickerService;

  Future<void> loadProfile() async {
    try {
      emit(state.copyWith(isLoading: true));
      final profile = await profileRepository.getProfile();
      final partnerProfile = profile.user.partnerProfile;

      if (partnerProfile != null) {
        emit(
          state.copyWith(
            companyName: partnerProfile.companyName ?? '',
            description: partnerProfile.description ?? '',
            cardNumber: partnerProfile.cardNumber ?? '',
            avatarUrl: profile.user.imageUrl,
            isLoading: false,
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } on Object catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  void updateCompanyName(String value) {
    emit(state.copyWith(companyName: value));
  }

  void updateDescription(String value) {
    emit(state.copyWith(description: value));
  }

  void updateCardNumber(String value) {
    emit(state.copyWith(cardNumber: value));
  }

  void updateAvatarUrl(String? url) {
    emit(state.copyWith(avatarUrl: url));
  }

  void toggleTermsAccepted() {
    emit(state.copyWith(isTermsAccepted: !state.isTermsAccepted));
  }

  Future<void> pickDocuments(BuildContext context) async {
    try {
      emit(state.copyWith(isUploadingDocuments: true));
      final files = await imagePickerService.pickMultipleImages(
        context: context,
        limit: 5,
      );

      if (files.isEmpty) {
        emit(state.copyWith(isUploadingDocuments: false));
        return;
      }

      final fileList = files.map((file) => File(file.path)).toList();
      final result = await uploadRepository.uploadMultipleFiles(
        UploadEnumParam.document,
        fileList,
      );

      final documentUrls = result.data.map((e) => e.url).whereType<String>().toList();
      emit(
        state.copyWith(
          documentUrls: [...state.documentUrls, ...documentUrls],
          isUploadingDocuments: false,
        ),
      );
    } on Object catch (e) {
      emit(state.copyWith(isUploadingDocuments: false, error: e));
    }
  }

  Future<void> takePhoto(BuildContext context) async {
    try {
      emit(state.copyWith(isUploadingDocuments: true));
      final files = await imagePickerService.pickMultipleImages(
        context: context,
        limit: 1,
      );

      if (files.isEmpty) {
        emit(state.copyWith(isUploadingDocuments: false));
        return;
      }

      final file = File(files.first.path);
      final result = await uploadRepository.uploadSingleFile(
        UploadEnumParam.document,
        file,
      );

      final url = result.data.url;
      if (url != null && url.isNotEmpty) {
        emit(
          state.copyWith(
            documentUrls: [...state.documentUrls, url],
            isUploadingDocuments: false,
          ),
        );
      } else {
        emit(state.copyWith(isUploadingDocuments: false));
      }
    } on Object catch (e) {
      emit(state.copyWith(isUploadingDocuments: false, error: e));
    }
  }

  Future<void> submitVerification() async {
    if (!_validateForm()) return;

    try {
      emit(state.copyWith(isSubmitting: true, error: null));

      final documentsUrl = state.documentUrls.join(',');

      await profileRepository.updatePartnerProfile(
        PartnerProfileParam(
          companyName: state.companyName.trim(),
          description: state.description.trim(),
          cardNumber: state.cardNumber.replaceAll(' ', ''),
          documentsUrl: documentsUrl,
        ),
      );
      await profileRepository.getProfile();

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } on Object catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e));
    }
  }

  bool _validateForm() {
    if (state.companyName.trim().isEmpty) {
      emit(state.copyWith(error: Exception('Название компании обязательно')));
      return false;
    }
    if (state.description.trim().isEmpty) {
      emit(state.copyWith(error: Exception('Описание обязательно')));
      return false;
    }
    if (state.cardNumber.replaceAll(' ', '').length < 16) {
      emit(state.copyWith(error: Exception('Номер карты должен содержать 16 цифр')));
      return false;
    }
    if (state.documentUrls.isEmpty) {
      emit(state.copyWith(error: Exception('Необходимо приложить документы')));
      return false;
    }
    if (!state.isTermsAccepted) {
      emit(state.copyWith(error: Exception('Необходимо согласиться с условиями')));
      return false;
    }
    return true;
  }
}
