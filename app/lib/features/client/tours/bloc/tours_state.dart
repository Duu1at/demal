part of 'tours_bloc.dart';

@immutable
final class ToursState extends PagingStateBase<int, TourModel> {
  ToursState({
    super.pages,
    super.keys,
    super.error,
    super.hasNextPage,
    super.isLoading,
    this.params,
  });

  final ToursParam? params;

  @override
  ToursState copyWith({
    Defaulted<List<List<TourModel>>?>? pages = const Omit(),
    Defaulted<List<int>?>? keys = const Omit(),
    Defaulted<Object?>? error = const Omit(),
    Defaulted<bool>? hasNextPage = const Omit(),
    Defaulted<bool>? isLoading = const Omit(),
    Defaulted<ToursParam?>? params = const Omit(),
  }) {
    return ToursState(
      pages: pages is Omit ? this.pages : pages as List<List<TourModel>>?,
      keys: keys is Omit ? this.keys : keys as List<int>?,
      error: error is Omit ? this.error : error,
      hasNextPage: hasNextPage is Omit ? this.hasNextPage : hasNextPage! as bool,
      isLoading: isLoading is Omit ? this.isLoading : isLoading! as bool,
      params: params is Omit ? this.params : params as ToursParam?,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ToursState && super == other && params == other.params;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, params);
}
