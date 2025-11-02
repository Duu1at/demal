part of 'tours_bloc.dart';

sealed class ToursEvent extends Equatable {
  const ToursEvent();

  @override
  List<Object> get props => [];
}

final class ToursFetchEvent extends ToursEvent {
  const ToursFetchEvent(this.params);

  final ToursParams params;

  @override
  List<Object> get props => [params];
}