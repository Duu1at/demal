part of 'create_tour_form_cubit.dart';

enum CreateTourStep { basicInfo, details, media }

class CreateTourFormState extends Equatable {
  const CreateTourFormState({
    this.currentStep = CreateTourStep.basicInfo,
    this.tourId,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
    // Step 1: Basic Info
    this.title = '',
    this.tourType = '',
    this.location = '',
    this.date = '',
    this.time = '',
    this.price = 0,
    this.currency = 'KGS',
    this.availableSpots = 0,
    // Step 2: Details
    this.description = '',
    this.program = const {},
    this.meetingPointAddress = '',
    this.meetingPointCoordinates = '',
    this.whatsIncluded = const [],
    this.whatsNotIncluded = const [],
    this.whatToBring = '',
    // Step 3: Media
    this.mainImageUrl = '',
    this.imageGalleryUrls = const [],
  });

  final CreateTourStep currentStep;
  final String? tourId;
  final bool isSubmitting;
  final bool isSuccess;
  final Object? error;

  // Step 1
  final String title;
  final String tourType;
  final String location;
  final String date;
  final String time;
  final int price;
  final String currency;
  final int availableSpots;

  // Step 2
  final String description;
  final Map<String, String> program;
  final String meetingPointAddress;
  final String meetingPointCoordinates;
  final List<String> whatsIncluded;
  final List<String> whatsNotIncluded;
  final String whatToBring;

  // Step 3
  final String mainImageUrl;
  final List<String> imageGalleryUrls;

  CreateTourFormState copyWith({
    CreateTourStep? currentStep,
    String? tourId,
    bool? isSubmitting,
    bool? isSuccess,
    Object? error,
    String? title,
    String? tourType,
    String? location,
    String? date,
    String? time,
    int? price,
    String? currency,
    int? availableSpots,
    String? description,
    Map<String, String>? program,
    String? meetingPointAddress,
    String? meetingPointCoordinates,
    List<String>? whatsIncluded,
    List<String>? whatsNotIncluded,
    String? whatToBring,
    String? mainImageUrl,
    List<String>? imageGalleryUrls,
  }) {
    return CreateTourFormState(
      currentStep: currentStep ?? this.currentStep,
      tourId: tourId ?? this.tourId,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      title: title ?? this.title,
      tourType: tourType ?? this.tourType,
      location: location ?? this.location,
      date: date ?? this.date,
      time: time ?? this.time,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      availableSpots: availableSpots ?? this.availableSpots,
      description: description ?? this.description,
      program: program ?? this.program,
      meetingPointAddress: meetingPointAddress ?? this.meetingPointAddress,
      meetingPointCoordinates: meetingPointCoordinates ?? this.meetingPointCoordinates,
      whatsIncluded: whatsIncluded ?? this.whatsIncluded,
      whatsNotIncluded: whatsNotIncluded ?? this.whatsNotIncluded,
      whatToBring: whatToBring ?? this.whatToBring,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      imageGalleryUrls: imageGalleryUrls ?? this.imageGalleryUrls,
    );
  }

  bool get canProceedToStep2 {
    return title.isNotEmpty &&
        tourType.isNotEmpty &&
        location.isNotEmpty &&
        date.isNotEmpty &&
        time.isNotEmpty &&
        price > 0 &&
        availableSpots > 0;
  }

  bool get canProceedToStep3 {
    return whatsIncluded.isNotEmpty && whatsNotIncluded.isNotEmpty;
  }

  bool get canSubmit {
    return mainImageUrl.isNotEmpty && imageGalleryUrls.isNotEmpty;
  }

  @override
  List<Object?> get props => [
    currentStep,
    tourId,
    isSubmitting,
    isSuccess,
    error,
    title,
    tourType,
    location,
    date,
    time,
    price,
    currency,
    availableSpots,
    description,
    program,
    meetingPointAddress,
    meetingPointCoordinates,
    whatsIncluded,
    whatsNotIncluded,
    whatToBring,
    mainImageUrl,
    imageGalleryUrls,
  ];
}
