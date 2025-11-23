import 'dart:io';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:upload_repository/upload_repository.dart';

part 'partner_verification_event.dart';
part 'partner_verification_state.dart';

class PartnerVerificationBloc
    extends Bloc<PartnerVerificationEvent, PartnerVerificationState> {
  PartnerVerificationBloc({
    required ProfileRepository profileRepository,
    required UploadRepository uploadRepository,
  })  : _profileRepository = profileRepository,
        _uploadRepository = uploadRepository,
        super(const PartnerVerificationState.initial()) {
    on<PartnerVerificationStatusChecked>(_onStatusChecked);
    on<PartnerVerificationFormSubmitted>(_onFormSubmitted, transformer: droppable());
    on<PartnerVerificationDocumentSelected>(_onDocumentSelected);
    on<PartnerVerificationProfileImageSelected>(_onProfileImageSelected);
    on<PartnerVerificationFormChanged>(_onFormChanged);
  }

  final ProfileRepository _profileRepository;
  final UploadRepository _uploadRepository;

  Future<void> _onStatusChecked(
    PartnerVerificationStatusChecked event,
    Emitter<PartnerVerificationState> emit,
  ) async {
    emit(state.copyWith(status: PartnerVerificationStatus.loading));
    try {
      final verifyStatus = await _profileRepository.getPartnerVerifyStatus();
      emit(
        state.copyWith(
          status: PartnerVerificationStatus.loaded,
          verificationStatus: verifyStatus.verificationStatus,
          adminComments: verifyStatus.adminComments,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: PartnerVerificationStatus.error,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onFormSubmitted(
    PartnerVerificationFormSubmitted event,
    Emitter<PartnerVerificationState> emit,
  ) async {
    if (!state.isFormValid) {
      emit(state.copyWith(status: PartnerVerificationStatus.validationError));
      return;
    }

    emit(state.copyWith(status: PartnerVerificationStatus.submitting));

    try {
      var documentsUrl = state.documentUrl;
      var profileImageUrl = state.profileImageUrl;

      // Загружаем документ, если выбран
      if (state.documentFile != null) {
        final uploadResult = await _uploadRepository.uploadSingleFile(
          UploadEnumParam.document,
          state.documentFile!,
        );
        documentsUrl = uploadResult.data.url;
      }

      // Загружаем фото профиля, если выбрано
      if (state.profileImageFile != null) {
        final uploadResult = await _uploadRepository.uploadSingleFile(
          UploadEnumParam.image,
          state.profileImageFile!,
        );
        profileImageUrl = uploadResult.data.url;
      }

      // Создаем/обновляем профиль партнера
      final param = PartnerProfileParam(
        companyName: state.companyName,
        description: state.description,
        documentsUrl: documentsUrl ?? '',
        cardNumber: state.cardNumber,
      );

      await _profileRepository.updatePartnerProfile(param);

      // Обновляем фото профиля пользователя, если загружено
      if (profileImageUrl != null) {
        await _profileRepository.updateProfile(
          ProfileUpdateParam(imageUrl: profileImageUrl),
        );
      }

      // Проверяем статус верификации
      final verifyStatus = await _profileRepository.getPartnerVerifyStatus();

      emit(
        state.copyWith(
          status: PartnerVerificationStatus.submitted,
          verificationStatus: verifyStatus.verificationStatus,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: PartnerVerificationStatus.error,
          error: error.toString(),
        ),
      );
    }
  }

  void _onDocumentSelected(
    PartnerVerificationDocumentSelected event,
    Emitter<PartnerVerificationState> emit,
  ) {
    emit(
      state.copyWith(
        documentFile: event.file,
        documentUrl: null,
      ),
    );
  }

  void _onProfileImageSelected(
    PartnerVerificationProfileImageSelected event,
    Emitter<PartnerVerificationState> emit,
  ) {
    emit(
      state.copyWith(
        profileImageFile: event.file,
        profileImageUrl: null,
      ),
    );
  }

  void _onFormChanged(
    PartnerVerificationFormChanged event,
    Emitter<PartnerVerificationState> emit,
  ) {
    emit(
      state.copyWith(
        companyName: event.companyName ?? state.companyName,
        description: event.description ?? state.description,
        cardNumber: event.cardNumber ?? state.cardNumber,
        agreedToTerms: event.agreedToTerms ?? state.agreedToTerms,
      ),
    );
  }
}
