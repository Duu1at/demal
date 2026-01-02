part of 'tours_bloc.dart';

sealed class ToursEvent extends Equatable {
  const ToursEvent();
  @override
  List<Object?> get props => [];
}

@immutable
final class ToursFetchNext extends ToursEvent {
  const ToursFetchNext(this.pageNumber);
  final int pageNumber;

  @override
  List<Object?> get props => [pageNumber];
}

@immutable
final class ToursRefresh extends ToursEvent {
  const ToursRefresh();
}

@immutable
final class ToursFilterChanged extends ToursEvent {
  const ToursFilterChanged(this.params);
  final ToursParam params;

  @override
  List<Object?> get props => [params];
}
