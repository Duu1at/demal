import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_repository/tour_repository.dart';
import 'package:upload_repository/upload_repository.dart';

part 'create_tour_form_state.dart';

class CreateTourFormCubit extends Cubit<CreateTourFormState> {
  CreateTourFormCubit({
    required this.tourRepository,
    required this.uploadRepository,
    this.tour,
  }) : super(const CreateTourFormState()) {
    if (tour != null) {
      _loadTourForEditing();
    }
  }

  final TourRepository tourRepository;
  final UploadRepository uploadRepository;
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
        price: tour!.price ?? 0,
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

  // Step 1: Basic Info
  void updateTitle(String value) => emit(state.copyWith(title: value));
  void updateTourType(String value) => emit(state.copyWith(tourType: value));
  void updateLocation(String value) => emit(state.copyWith(location: value));
  void updateDate(String value) => emit(state.copyWith(date: value));
  void updateTime(String value) => emit(state.copyWith(time: value));
  void updatePrice(int value) => emit(state.copyWith(price: value));
  void updateCurrency(String value) => emit(state.copyWith(currency: value));
  void updateAvailableSpots(int value) => emit(state.copyWith(availableSpots: value));
  void updateMainImageUrl(String url) {
    if (state.mainImageUrl.isNotEmpty && state.mainImageUrl != url) {
      uploadRepository.deleteFile(state.mainImageUrl);
    }
    emit(state.copyWith(mainImageUrl: url));
  }

  void addGalleryImageUrls(List<String> urls) =>
      emit(state.copyWith(imageGalleryUrls: [...state.imageGalleryUrls, ...urls]));
  void removeGalleryImage(int index) {
    if (index >= 0 && index < state.imageGalleryUrls.length) {
      final urlToDelete = state.imageGalleryUrls[index];
      uploadRepository.deleteFile(urlToDelete);
      final updated = List<String>.from(state.imageGalleryUrls)..removeAt(index);
      emit(state.copyWith(imageGalleryUrls: updated));
    }
  }

  // Step 2: Details
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

  Future<void> submit() async {
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
        // Edit mode
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
        // Create mode
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

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } on Object catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e));
    }
  }
}
