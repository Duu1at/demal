import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract interface class PagedResult<T> {
  List<T> get items;

  PaginationInfo? get pagination;

  bool? get success;
}

abstract interface class PaginationInfo {
  int get page;
  int get limit;
  int get totalItems;
  int get totalPages;
}

sealed class PagingEvent {
  const PagingEvent();
}

final class PagingFetchNext extends PagingEvent {
  const PagingFetchNext();
}

final class PagingRefresh extends PagingEvent {
  const PagingRefresh();
}

final class PagingChangeParams<P> extends PagingEvent {
  const PagingChangeParams(this.params);

  final P? params;
}

@immutable
final class BlocPagingState<T, P> extends PagingStateBase<int, T> {
  BlocPagingState({
    super.pages,
    super.keys,
    super.error,
    super.hasNextPage,
    super.isLoading,
    this.params,
  });

  final P? params;

  @override
  BlocPagingState<T, P> copyWith({
    Defaulted<List<List<T>>?>? pages = const Omit(),
    Defaulted<List<int>?>? keys = const Omit(),
    Defaulted<Object?>? error = const Omit(),
    Defaulted<bool>? hasNextPage = const Omit(),
    Defaulted<bool>? isLoading = const Omit(),
    Defaulted<P?> params = const Omit(),
  }) => BlocPagingState<T, P>(
    pages: pages is Omit ? this.pages : pages as List<List<T>>?,
    keys: keys is Omit ? this.keys : keys as List<int>?,
    error: error is Omit ? this.error : error,
    hasNextPage: hasNextPage is Omit ? this.hasNextPage : hasNextPage! as bool,
    isLoading: isLoading is Omit ? this.isLoading : isLoading! as bool,
    params: params is Omit ? this.params : params as P?,
  );

  @override
  BlocPagingState<T, P> reset() => BlocPagingState<T, P>(
    pages: null,
    keys: null,
    error: null,
    hasNextPage: true,
    isLoading: false,
    params: null,
  );
}

class PagingBloc<T, P> extends Bloc<PagingEvent, BlocPagingState<T, P>> {
  PagingBloc({
    required this.fetchFn,
  }) : super(BlocPagingState<T, P>()) {
    on<PagingFetchNext>(_onFetchNext);
    on<PagingRefresh>(_onRefresh);
    on<PagingChangeParams<P>>(_onChangeParams);
  }

  final Future<PagedResult<T>> Function(int pageKey, P? params) fetchFn;

  Future<void> _onFetchNext(
    PagingFetchNext event,
    Emitter<BlocPagingState<T, P>> emit,
  ) async {
    final current = state;
    if (current.isLoading || !current.hasNextPage) return;
    final pageKey = current.lastPageIsEmpty ? null : current.nextIntPageKey;

    if (pageKey == null) {
      emit(current.copyWith(hasNextPage: false));
      return;
    }
    emit(
      current.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      final result = await fetchFn(pageKey, current.params);
      final items = result.items;
      final pagination = result.pagination;

      final isLastPage = _isLastPage(items, pageKey, pagination);

      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          hasNextPage: !isLastPage,
          pages: [...?state.pages, items],
          keys: [...?state.keys, pageKey],
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  bool _isLastPage(List<T> items, int pageKey, PaginationInfo? pagination) {
    if (items.isEmpty) return true;
    if (pagination != null) {
      return pageKey >= pagination.totalPages;
    }
    return false;
  }

  Future<void> _onRefresh(
    PagingRefresh event,
    Emitter<BlocPagingState<T, P>> emit,
  ) async {
    emit(state.reset());
    add(const PagingFetchNext());
  }

  Future<void> _onChangeParams(
    PagingChangeParams<P> event,
    Emitter<BlocPagingState<T, P>> emit,
  ) async {
    emit(state.reset().copyWith(params: event.params));
    add(const PagingFetchNext());
  }
}
