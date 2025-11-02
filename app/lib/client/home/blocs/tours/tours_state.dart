part of 'tours_bloc.dart';

enum ToursStatus { initial, loading, success, failure }

final class ToursState extends Equatable {
  const ToursState({
    this.status = ToursStatus.initial,
    this.tours = const <TourModel>[],
    this.hasReachedMax = false,
    this.exception,
    this.params,
    this.currentPage = 1,
    this.pagination,
    this.isRefreshing = false,
  });

  final ToursStatus status;
  final List<TourModel> tours;
  final bool hasReachedMax;
  final Object? exception;
  final ToursParams? params;
  final int currentPage;
  final PaginationModel? pagination;
  final bool isRefreshing;

  bool get canLoadMore {
    if (pagination == null) return false;
    return currentPage < pagination!.totalPages && !hasReachedMax;
  }

  ToursState copyWith({
    ToursStatus? status,
    List<TourModel>? tours,
    bool? hasReachedMax,
    Object? exception,
    ToursParams? params,
    int? currentPage,
    PaginationModel? pagination,
    bool? isRefreshing,
    bool clearTours = false,
    bool clearException = false,
  }) {
    return ToursState(
      status: status ?? this.status,
      tours: clearTours ? const <TourModel>[] : (tours ?? this.tours),
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      exception: clearException ? null : (exception ?? this.exception),
      params: params ?? this.params,
      currentPage: currentPage ?? this.currentPage,
      pagination: pagination ?? this.pagination,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  String toString() {
    return '''ToursState { 
      status: $status, 
      hasReachedMax: $hasReachedMax, 
      tours: ${tours.length}, 
      currentPage: $currentPage,
      canLoadMore: $canLoadMore,
      exception: $exception, 
      params: $params 
    }''';
  }

  @override
  List<Object?> get props => [
    status,
    tours,
    hasReachedMax,
    exception,
    params,
    currentPage,
    pagination,
    isRefreshing,
  ];
}
