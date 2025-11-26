import 'dart:io';

import 'package:app/utils/image_picker_service/image_picker_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';
import 'package:upload_repository/upload_repository.dart';

part 'create_tour_state.dart';

class CreateTourCubit extends Cubit<CreateTourState> {
  CreateTourCubit({
    required this.tourRepository,
    required this.uploadRepository,
    required this.imagePickerService,
    this.tour,
  }) : super(const CreateTourState()) {
    if (tour != null) {
      _loadTourForEditing();
    }
  }

  final TourRepository tourRepository;
  final UploadRepository uploadRepository;
  final ImagePickerService imagePickerService;
  final TourModel? tour;

  void _loadTourForEditing() {
    if (tour == null) return;

    emit(
      state.copyWith(
        tourId: tour!.tourId,
        title: tour!.title ?? '',
        tourType: tour!.tourType ?? '',
        location: tour!.location ?? '',
        date: tour!.date ?? '',
        time: tour!.time ?? '',
        price: (tour!.price ?? 0).toDouble(),
        currency: tour!.currency ?? 'KGS',
        availableSpots: tour!.availableSpots ?? 0,
        description: tour!.description ?? '',
        program: tour!.program ?? {},
        meetingPointAddress: tour!.meetingPoint?.address ?? '',
        meetingPointCoordinates: tour!.meetingPoint?.coordinates ?? '',
        whatsIncluded: tour!.whatsIncluded ?? [],
        whatsNotIncluded: tour!.whatsNotIncluded ?? [],
        whatToBring: tour!.whatToBring ?? '',
        mainImageUrl: tour!.mainImageUrl ?? '',
        imageGalleryUrls: tour!.imageGalleryUrls ?? [],
      ),
    );
  }

  void nextStep() {
    if (state.currentStep == CreateTourStep.basicInfo && state.canProceedToStep2) {
      emit(state.copyWith(currentStep: CreateTourStep.details));
    } else if (state.currentStep == CreateTourStep.details && state.canProceedToStep3) {
      emit(state.copyWith(currentStep: CreateTourStep.media));
    }
  }

  void previousStep() {
    if (state.currentStep == CreateTourStep.details) {
      emit(state.copyWith(currentStep: CreateTourStep.basicInfo));
    } else if (state.currentStep == CreateTourStep.media) {
      emit(state.copyWith(currentStep: CreateTourStep.details));
    }
  }

  void goToStep(CreateTourStep step) {
    emit(state.copyWith(currentStep: step));
  }

  // Шаг 1: Основная информация
  void updateTitle(String value) => emit(state.copyWith(title: value));
  void updateTourType(String value) => emit(state.copyWith(tourType: value));
  void updateLocation(String value) => emit(state.copyWith(location: value));
  void updateDate(String value) => emit(state.copyWith(date: value));
  void updateTime(String value) => emit(state.copyWith(time: value));
  void updatePrice(double value) => emit(state.copyWith(price: value));
  void updateCurrency(String value) => emit(state.copyWith(currency: value));
  void updateAvailableSpots(int value) => emit(state.copyWith(availableSpots: value));
  void updateMainImageUrl(String url) => emit(state.copyWith(mainImageUrl: url));

  // Шаг 2: Детали
  void updateDescription(String value) => emit(state.copyWith(description: value));
  void updateProgram(Map<String, String> value) => emit(state.copyWith(program: value));
  void updateMeetingPointAddress(String value) => emit(state.copyWith(meetingPointAddress: value));
  void updateMeetingPointCoordinates(String value) => emit(state.copyWith(meetingPointCoordinates: value));
  void updateWhatToBring(String value) => emit(state.copyWith(whatToBring: value));

  void addWhatsIncluded(String item) {
    if (item.trim().isEmpty) return;
    emit(state.copyWith(whatsIncluded: [...state.whatsIncluded, item.trim()]));
  }

  void removeWhatsIncluded(int index) {
    final updated = List<String>.from(state.whatsIncluded)..removeAt(index);
    emit(state.copyWith(whatsIncluded: updated));
  }

  void addWhatsNotIncluded(String item) {
    if (item.trim().isEmpty) return;
    emit(state.copyWith(whatsNotIncluded: [...state.whatsNotIncluded, item.trim()]));
  }

  void removeWhatsNotIncluded(int index) {
    final updated = List<String>.from(state.whatsNotIncluded)..removeAt(index);
    emit(state.copyWith(whatsNotIncluded: updated));
  }

  // Шаг 3: Медиа
  Future<void> pickMainImage(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));
      final files = await imagePickerService.pickMultipleImages(
        context: context,
        limit: 1,
      );

      if (files.isEmpty) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      final file = File(files.first.path);
      final result = await uploadRepository.uploadSingleFile(
        UploadEnumParam.image,
        file,
      );

      final url = result.data.url;
      if (url != null && url.isNotEmpty) {
        emit(state.copyWith(mainImageUrl: url, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } on Object catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  Future<void> pickGalleryImages(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));
      final files = await imagePickerService.pickMultipleImages(
        context: context,
        limit: 10,
      );

      if (files.isEmpty) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      final fileList = files.map((file) => File(file.path)).toList();
      final result = await uploadRepository.uploadMultipleFiles(
        UploadEnumParam.image,
        fileList,
      );

      final imageUrls = result.data.map((e) => e.url).whereType<String>().toList();
      emit(
        state.copyWith(
          imageGalleryUrls: [...state.imageGalleryUrls, ...imageUrls],
          isLoading: false,
        ),
      );
    } on Object catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  void removeGalleryImage(int index) {
    final updated = List<String>.from(state.imageGalleryUrls)..removeAt(index);
    emit(state.copyWith(imageGalleryUrls: updated));
  }

  Future<void> submit(BuildContext context) async {
    if (!state.canSubmit) {
      emit(state.copyWith(error: Exception('Заполните все обязательные поля')));
      return;
    }

    try {
      emit(state.copyWith(isSubmitting: true, error: null));

      final meetingPoint = state.meetingPointAddress.isNotEmpty
          ? MeetingPoint(
              address: state.meetingPointAddress,
              coordinates: state.meetingPointCoordinates.isNotEmpty ? state.meetingPointCoordinates : null,
            )
          : null;

      if (state.tourId != null) {
        // Редактирование существующего тура
        final updateParam = TourUpdateParam(
          title: state.title,
          tourType: state.tourType,
          location: state.location,
          date: state.date,
          time: state.time,
          price: state.price,
          currency: state.currency,
          availableSpots: state.availableSpots,
          description: state.description.isNotEmpty ? state.description : null,
          program: state.program.isNotEmpty ? state.program : null,
          meetingPoint: meetingPoint != null
              ? TourUpdateMeetingPoint(
                  address: meetingPoint.address,
                  coordinates: meetingPoint.coordinates,
                )
              : null,
          whatsIncluded: state.whatsIncluded,
          whatsNotIncluded: state.whatsNotIncluded,
          whatToBring: state.whatToBring.isNotEmpty ? state.whatToBring : null,
          mainImageUrl: state.mainImageUrl,
          imageGalleryUrls: state.imageGalleryUrls,
        );

        await tourRepository.updateTour(state.tourId!, updateParam);
      } else {
        // Создание нового тура
        final createParam = TourCreateParam(
          title: state.title,
          mainImageUrl: state.mainImageUrl,
          location: state.location,
          date: state.date,
          time: state.time,
          price: state.price,
          tourType: state.tourType,
          availableSpots: state.availableSpots,
          whatsIncluded: state.whatsIncluded,
          whatsNotIncluded: state.whatsNotIncluded,
          imageGalleryUrls: state.imageGalleryUrls,
          currency: state.currency,
          description: state.description.isNotEmpty ? state.description : null,
          program: state.program.isNotEmpty ? state.program : null,
          meetingPoint: meetingPoint,
          whatToBring: state.whatToBring.isNotEmpty ? state.whatToBring : null,
        );

        final createdTour = await tourRepository.createTour(createParam);
        emit(state.copyWith(tourId: createdTour.tourId));
      }

      emit(state.copyWith(isSubmitting: false));

      if (context.mounted) {
        context.pop(true); // Возвращаем true для обновления списка туров
      }
    } on Object catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e));
    }
  }
}
