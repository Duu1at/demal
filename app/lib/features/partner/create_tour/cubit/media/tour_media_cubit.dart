import 'dart:io';

import 'package:app/utils/image_picker_service/image_picker_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_repository/upload_repository.dart';

part 'tour_media_state.dart';

class TourMediaCubit extends Cubit<TourMediaState> {
  TourMediaCubit({
    required this.imagePickerService,
    required this.uploadRepository,
  }) : super(const TourMediaState());

  final ImagePickerService imagePickerService;
  final UploadRepository uploadRepository;

  Future<void> pickMainImage(BuildContext context) async {
    try {
      if (state.isMainImageLoading) return;
      emit(state.copyWith(isMainImageLoading: true, error: null));

      final files = await imagePickerService.pickMultipleImages(
        context: context,
        limit: 1,
      );

      if (files.isEmpty) {
        emit(state.copyWith(isMainImageLoading: false));
        return;
      }

      final file = File(files.first.path);
      final result = await uploadRepository.uploadSingleFile(
        UploadEnumParam.image,
        file,
      );

      final url = result.data.url;
      if (url != null && url.isNotEmpty) {
        // Emit specific success state that listener can react to
        emit(TourMediaSuccess(urls: [url], isMainFilter: true));
        // Reset back to base state to allow future updates
        emit(state.copyWith(isMainImageLoading: false));
      } else {
        emit(state.copyWith(isMainImageLoading: false));
      }
    } on Object catch (e) {
      emit(state.copyWith(isMainImageLoading: false, error: e));
    }
  }

  Future<void> pickGalleryImages(BuildContext context) async {
    try {
      if (state.isGalleryLoading) return;
      emit(state.copyWith(isGalleryLoading: true, error: null));

      final files = await imagePickerService.pickMultipleImages(
        context: context,
        limit: 10,
      );

      if (files.isEmpty) {
        emit(state.copyWith(isGalleryLoading: false));
        return;
      }

      final fileList = files.map((file) => File(file.path)).toList();
      final result = await uploadRepository.uploadMultipleFiles(
        UploadEnumParam.image,
        fileList,
      );

      final imageUrls = result.data.map((e) => e.url).whereType<String>().where((url) => url.isNotEmpty).toList();

      if (imageUrls.isNotEmpty) {
        emit(TourMediaSuccess(urls: imageUrls, isMainFilter: false));
        emit(state.copyWith(isGalleryLoading: false));
      } else {
        emit(state.copyWith(isGalleryLoading: false));
      }
    }on Object catch (e) {
      emit(state.copyWith(isGalleryLoading: false, error: e));
    }
  }
}
