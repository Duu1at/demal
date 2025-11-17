part of 'tours_bloc.dart';

@immutable
final class ToursState<T> extends PagingStateBase<int, T> {
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
  ToursState<T> copyWith({
    Defaulted<List<List<T>>?>? pages = const Omit(),
    Defaulted<List<int>?>? keys = const Omit(),
    Defaulted<Object?>? error = const Omit(),
    Defaulted<bool>? hasNextPage = const Omit(),
    Defaulted<bool>? isLoading = const Omit(),
    Defaulted<ToursParam?> params = const Omit(),
  }) => ToursState<T>(
    pages: pages is Omit ? this.pages : pages as List<List<T>>?,
    keys: keys is Omit ? this.keys : keys as List<int>?,
    error: error is Omit ? this.error : error,
    hasNextPage: hasNextPage is Omit ? this.hasNextPage : hasNextPage! as bool,
    isLoading: isLoading is Omit ? this.isLoading : isLoading! as bool,
    params: params is Omit ? this.params : params as ToursParam?,
  );

  @override
  ToursState<T> reset() => ToursState<T>(
    pages: null,
    keys: null,
    error: null,
    hasNextPage: true,
    isLoading: false,
    params: params,
  );

  @override
  bool operator ==(Object other) => other is ToursState<T> && super == other && params == other.params;

  @override
  int get hashCode => Object.hash(
    super.hashCode,
    params,
  );
}
