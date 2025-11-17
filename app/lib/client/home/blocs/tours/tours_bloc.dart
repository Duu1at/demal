import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:tour_repository/tour_repository.dart';

part 'tours_event.dart';
part 'tours_state.dart';

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

class ToursBloc extends Bloc<ToursEvent, ToursState<TourModel>> {
  ToursBloc(this._tourRepository) : super(ToursState()) {
    on<ToursFetchEvent>(_onFetch);
    // on<ToursRefreshEvent>(_onRefresh, transformer: throttleDroppable());
    // on<ToursFilterChangedEvent>(_onFilterChanged, transformer: debounceDroppable());
  }

  final TourRepository _tourRepository;

  Future<void> _onFetch(
    ToursFetchEvent event,
    Emitter<ToursState<TourModel>> emit,
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
      final result = await _fetchPage(current.params ?? ToursParam(page: pageKey, limit: tourLimit));

      final isLastPage = result.pagination?.totalPages == pageKey;
      emit(
        current.copyWith(
          isLoading: false,
          error: null,
          hasNextPage: !isLastPage,
          pages: [...?current.pages, result.tours ?? []],
          keys: [...?current.keys, pageKey],
        ),
      );
    } on Object catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  // Future<void> _onRefresh(
  //   ToursRefreshEvent event,
  //   Emitter<ToursPagingState> emit,
  // ) async {
  //   if (state.isLoading && !state.isRefreshing) return;

  //   final params =
  //       event.params ?? state.params?.copyWith(limit: tourLimit) ?? const ToursParam(page: 1, limit: tourLimit);

  //   emit(state.reset().copyWithParams(params: params));
  //   await _fetchPage(emit, 1, params);
  // }

  // Future<void> _onLoadMore(
  //   ToursLoadMoreEvent event,
  //   Emitter<ToursPagingState> emit,
  // ) async {
  //   if (state.isLoading || !state.canLoadMore) return;

  //   final nextPageKey = state.nextIntPageKey;
  //   await _fetchPage(emit, nextPageKey, state.params);
  // }

  // Future<void> _onFilterChanged(
  //   ToursFilterChangedEvent event,
  //   Emitter<ToursPagingState> emit,
  // ) async {
  //   final params = event.params.copyWith(limit: tourLimit);

  //   emit(state.reset().copyWithParams(params: params));
  //   await _fetchPage(emit, 1, params);
  // }

  Future<ToursModel> _fetchPage(ToursParam baseParams) {
    return _tourRepository.getTours(baseParams);
  }
}
