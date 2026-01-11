import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:upload_repository/upload_repository.dart';

class UpdateProfileCubit extends Cubit<RequestStatus<UserModel>> {
  UpdateProfileCubit({
    required this.profileRepository,
    required this.uploadRepository,
  }) : super(const RequestInitial());

  final ProfileRepository profileRepository;
  final UploadRepository uploadRepository;

  Future<void> updateProfile({
    required ProfileUpdateParam param,
    File? imageFile,
    VoidCallback? onSuccess,
  }) async {
    if (state is RequestLoading) return;
    try {
      emit(RequestLoading());
      var params = param;

      if (imageFile != null) {
        final image = await uploadRepository.uploadSingleFile(
          UploadEnumParam.image,
          imageFile,
        );
        params = ProfileUpdateParam(
          fullName: params.fullName,
          description: params.description,
          phoneNumber: params.phoneNumber,
          imageUrl: image.data.url,
        );
      }
      final profile = await profileRepository.updateProfile(params);
      emit(RequestSuccess(profile));
      onSuccess?.call();
    } on Object catch (e) {
      emit(RequestFailure(e));
    }
  }
}
