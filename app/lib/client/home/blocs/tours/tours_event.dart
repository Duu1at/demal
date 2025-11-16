part of 'tours_bloc.dart';

sealed class ToursEvent extends Equatable {
  const ToursEvent();

  @override
  List<Object> get props => [];
}

final class ToursInitialFetchEvent extends ToursEvent {
  const ToursInitialFetchEvent();
}

final class ToursRefreshEvent extends ToursEvent {
  const ToursRefreshEvent({this.params});

  final ToursParam? params;

  @override
  List<Object> get props => [params ?? const ToursParam()];
}

final class ToursLoadMoreEvent extends ToursEvent {
  const ToursLoadMoreEvent();
}

final class ToursFilterChangedEvent extends ToursEvent {
  const ToursFilterChangedEvent(this.params);

  final ToursParam params;

  @override
  List<Object> get props => [params];
}
