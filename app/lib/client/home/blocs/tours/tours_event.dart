part of 'tours_bloc.dart';

sealed class ToursEvent {
  const ToursEvent();
}

final class ToursFetchEvent extends ToursEvent {
  const ToursFetchEvent();
}

final class ToursRefreshEvent extends ToursEvent {
  const ToursRefreshEvent();
}

final class ToursFilterChangedEvent extends ToursEvent {
  const ToursFilterChangedEvent(this.params);
  final ToursParam params;
}
