part of 'tour_media_cubit.dart';

class TourMediaState extends Equatable {
  const TourMediaState({
    this.isMainImageLoading = false,
    this.isGalleryLoading = false,
    this.error,
  });

  final bool isMainImageLoading;
  final bool isGalleryLoading;
  final Object? error;

  TourMediaState copyWith({
    bool? isMainImageLoading,
    bool? isGalleryLoading,
    Object? error,
  }) {
    return TourMediaState(
      isMainImageLoading: isMainImageLoading ?? this.isMainImageLoading,
      isGalleryLoading: isGalleryLoading ?? this.isGalleryLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isMainImageLoading, isGalleryLoading, error];
}

class TourMediaSuccess extends TourMediaState {
  const TourMediaSuccess({
    required this.urls,
    required this.isMainFilter,
  });

  final List<String> urls;
  final bool isMainFilter;

  @override
  List<Object?> get props => [urls, isMainFilter, ...super.props];
}
