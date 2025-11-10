import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stream_transform/stream_transform.dart';

part 'tours_event.dart';
part 'tours_paging_state.dart';

EventTransformer<E> debounceDroppable<E>() {
  return (events, mapper) {
    return droppable<E>().call(
      events.debounce(const Duration(milliseconds: 500)),
      mapper,
    );
  };
}

EventTransformer<E> throttleDroppable<E>() {
  return (events, mapper) {
    return droppable<E>().call(
      events.throttle(const Duration(milliseconds: 300)),
      mapper,
    );
  };
}

const int tourLimit = 10;

class ToursBloc extends Bloc<ToursEvent, ToursPagingState> {
  ToursBloc(this._clientTourRepository) : super(ToursPagingState()) {
    on<ToursInitialFetchEvent>(_onInitialFetch);
    on<ToursRefreshEvent>(_onRefresh, transformer: throttleDroppable());
    on<ToursLoadMoreEvent>(_onLoadMore, transformer: throttleDroppable());
    on<ToursFilterChangedEvent>(
      _onFilterChanged,
      transformer: debounceDroppable(),
    );
  }

  final ClientTourRepository _clientTourRepository;

  Future<void> _onInitialFetch(
    ToursInitialFetchEvent event,
    Emitter<ToursPagingState> emit,
  ) async {
    if (state.pages != null && state.pages!.isNotEmpty) return;

    await _fetchPage(emit, 1, state.params);
  }

  Future<void> _onRefresh(
    ToursRefreshEvent event,
    Emitter<ToursPagingState> emit,
  ) async {
    if (state.isLoading && !state.isRefreshing) return;

    final params =
        event.params ?? state.params?.copyWith(limit: tourLimit) ?? const ToursParams(page: 1, limit: tourLimit);

    emit(state.reset().copyWithParams(params: params));
    await _fetchPage(emit, 1, params);
  }

  Future<void> _onLoadMore(
    ToursLoadMoreEvent event,
    Emitter<ToursPagingState> emit,
  ) async {
    if (state.isLoading || !state.canLoadMore) return;

    final nextPageKey = state.nextIntPageKey;
    await _fetchPage(emit, nextPageKey, state.params);
  }

  Future<void> _onFilterChanged(
    ToursFilterChangedEvent event,
    Emitter<ToursPagingState> emit,
  ) async {
    final params = event.params.copyWith(limit: tourLimit);

    emit(state.reset().copyWithParams(params: params));
    await _fetchPage(emit, 1, params);
  }

  Future<void> _fetchPage(
    Emitter<ToursPagingState> emit,
    int pageKey,
    ToursParams? baseParams,
  ) async {
    final params = (baseParams ?? const ToursParams()).copyWith(
      page: pageKey,
      limit: tourLimit,
    );

    emit(state.copyWithParams(isLoading: true, params: params));

    try {
      final result = await _clientTourRepository.getTours(params);
      final tours = result.tours ?? [];
      final pagination = result.pagination;

      final isLastPage = pagination != null
          ? pageKey >= pagination.totalPages
          : tours.isEmpty || tours.length < tourLimit;

      emit(
        state.copyWithParams(
          isLoading: false,
          hasNextPage: !isLastPage,
          pages: pageKey == 1 ? [tours] : [...?state.pages, tours],
          keys: pageKey == 1 ? [pageKey] : [...?state.keys, pageKey],
          pagination: pagination,
        ),
      );
    } catch (e) {
      emit(state.copyWithParams(isLoading: false, error: e));
    }
  }

  @override
  Future<void> close() {
    state.params?.clearAll();
    return super.close();
  }
}
