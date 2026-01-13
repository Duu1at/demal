part of 'tour_detail_bloc.dart';

sealed class TourDetailState extends Equatable {
  const TourDetailState();

  @override
  List<Object> get props => [];
}

final class TourDetailInitial extends TourDetailState {
  const TourDetailInitial();
}

final class TourDetailLoading extends TourDetailState {
  const TourDetailLoading();
}

final class TourDetailSuccess extends TourDetailState {
  const TourDetailSuccess(this.tour);
  final TourModel tour;

  @override
  List<Object> get props => [tour];
}

final class TourDetailError extends TourDetailState {
  const TourDetailError(this.error);
  final Object error;

  @override
  List<Object> get props => [error];
}
