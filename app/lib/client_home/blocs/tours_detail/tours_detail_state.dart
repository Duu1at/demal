part of 'tours_detail_bloc.dart';

sealed class ToursDetailState extends Equatable {
  const ToursDetailState();

  @override
  List<Object> get props => [];
}

final class ToursDetailInitial extends ToursDetailState {
  const ToursDetailInitial();
}

final class ToursDetailLoading extends ToursDetailState {
  const ToursDetailLoading();
}

final class ToursDetailSuccess extends ToursDetailState {
  const ToursDetailSuccess(this.tour);
  final TourModel tour;

  @override
  List<Object> get props => [tour];
}

final class ToursDetailError extends ToursDetailState {
  const ToursDetailError(this.error);
  final Object error;

  @override
  List<Object> get props => [error];
}
