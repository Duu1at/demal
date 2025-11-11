part of 'tours_bloc.dart';

@immutable
final class ToursPagingState extends PagingStateBase<int, TourModel> {
  ToursPagingState({
    super.pages,
    super.keys,
    super.error,
    super.hasNextPage,
    super.isLoading,
    this.params,
    this.pagination,
  });

  final ToursParams? params;
  final PaginationModel? pagination;

  List<TourModel> get allTours => pages?.expand((page) => page).toList() ?? [];

  int get currentPage => pagination?.page ?? (keys?.lastOrNull ?? 0);

  bool get canLoadMore {
    if (pagination != null) {
      return currentPage < pagination!.totalPages && hasNextPage;
    }
    return hasNextPage;
  }

  bool get isRefreshing => isLoading && (keys?.isEmpty ?? true);

  @override
  ToursPagingState copyWith({
    FutureOr<List<List<TourModel>>?>? pages,
    FutureOr<List<int>?>? keys,
    FutureOr<Object?>? error,
    FutureOr<bool>? hasNextPage,
    FutureOr<bool>? isLoading,
  }) {
    return ToursPagingState(
      pages: pages != null ? (pages is Future ? this.pages : pages) : this.pages,
      keys: keys != null ? (keys is Future ? this.keys : keys) : this.keys,
      error: error != null ? (error is Future ? this.error : error) : this.error,
      hasNextPage: hasNextPage != null ? (hasNextPage is Future ? this.hasNextPage : hasNextPage) : this.hasNextPage,
      isLoading: isLoading != null ? (isLoading is Future ? this.isLoading : isLoading) : this.isLoading,
      params: params,
      pagination: pagination,
    );
  }

  ToursPagingState copyWithParams({
    FutureOr<List<List<TourModel>>?>? pages,
    FutureOr<List<int>?>? keys,
    FutureOr<Object?>? error,
    FutureOr<bool>? hasNextPage,
    FutureOr<bool>? isLoading,
    ToursParams? params,
    PaginationModel? pagination,
  }) {
    return ToursPagingState(
      pages: pages != null ? (pages is Future ? this.pages : pages) : this.pages,
      keys: keys != null ? (keys is Future ? this.keys : keys) : this.keys,
      error: error != null ? (error is Future ? this.error : error) : this.error,
      hasNextPage: hasNextPage != null ? (hasNextPage is Future ? this.hasNextPage : hasNextPage) : this.hasNextPage,
      isLoading: isLoading != null ? (isLoading is Future ? this.isLoading : isLoading) : this.isLoading,
      params: params ?? this.params,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  ToursPagingState reset() {
    return ToursPagingState(params: params);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToursPagingState &&
          runtimeType == other.runtimeType &&
          pages == other.pages &&
          keys == other.keys &&
          error == other.error &&
          hasNextPage == other.hasNextPage &&
          isLoading == other.isLoading &&
          params == other.params &&
          pagination == other.pagination;

  @override
  int get hashCode => Object.hash(
    pages,
    keys,
    error,
    hasNextPage,
    isLoading,
    params,
    pagination,
  );
}
