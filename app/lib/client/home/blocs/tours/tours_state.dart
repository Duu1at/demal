part of 'tours_bloc.dart';

enum ToursStatus { initial, loading, success, failure }

final class ToursState extends Equatable {
  const ToursState({
    this.status = ToursStatus.initial,
    this.tours = const <ToursModel>[],
    this.hasReachedMax = false,
    this.exception,
    this.params,
  });

  final ToursStatus status;
  final List<ToursModel> tours;
  final bool hasReachedMax;
  final Object? exception;
  final ToursParams? params;

  ToursState copyWith({
    ToursStatus? status,
    List<ToursModel>? tours,
    bool? hasReachedMax,
    Object? exception,
    ToursParams? params,
  }) {
    return ToursState(
      status: status ?? this.status,
      tours: tours ?? this.tours,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      exception: exception ?? this.exception,
      params: params ?? this.params,
    );
  }

  @override
  String toString() {
    return '''ToursState { status: $status, hasReachedMax: $hasReachedMax, tours: ${tours.length}, exception: $exception, params: $params }''';
  }

  @override
  List<Object?> get props => [status, tours, hasReachedMax, exception, params];
}
