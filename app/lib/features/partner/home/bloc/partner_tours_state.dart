part of 'partner_tours_bloc.dart';

@immutable
final class PartnerToursState extends PagingStateBase<int, TourModel> {
  PartnerToursState({
    super.pages,
    super.keys,
    super.error,
    super.hasNextPage,
    super.isLoading,
  });

  @override
  PartnerToursState copyWith({
    Defaulted<List<List<TourModel>>?>? pages = const Omit(),
    Defaulted<List<int>?>? keys = const Omit(),
    Defaulted<Object?>? error = const Omit(),
    Defaulted<bool>? hasNextPage = const Omit(),
    Defaulted<bool>? isLoading = const Omit(),
  }) => PartnerToursState(
    pages: pages is Omit ? this.pages : pages as List<List<TourModel>>?,
    keys: keys is Omit ? this.keys : keys as List<int>?,
    error: error is Omit ? this.error : error,
    hasNextPage: hasNextPage is Omit ? this.hasNextPage : hasNextPage! as bool,
    isLoading: isLoading is Omit ? this.isLoading : isLoading! as bool,
  );

  @override
  PartnerToursState reset() => PartnerToursState(
    pages: null,
    keys: null,
    error: null,
    hasNextPage: true,
    isLoading: false,
  );

  @override
  bool operator ==(Object other) {
    return other is PartnerToursState && super == other;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, error, hasNextPage, isLoading, pages, keys);
}
