import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:tour_repository/tour_repository.dart';

part 'tours_event.dart';
part 'tours_state.dart';

const int _pageSize = 5;
const Duration _searchDebounce = Duration(milliseconds: 500);

EventTransformer<T> _debounce<T>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class ToursBloc extends Bloc<ToursEvent, ToursState> {
  ToursBloc(this._tourRepository) : super(ToursState()) {
    on<ToursFetchNext>(_onFetchNext);
    on<ToursRefresh>(_onRefresh);
    on<ToursFilterChanged>(
      _onFilterChanged,
      transformer: _debounce(_searchDebounce),
    );
  }

  final TourRepository _tourRepository;

  Future<void> _onFetchNext(
    ToursFetchNext event,
    Emitter<ToursState> emit,
  ) async {
    final current = state;

    if (current.isLoading || !current.hasNextPage) return;

    emit(current.copyWith(isLoading: true));

    try {
      final params = (current.params ?? const ToursParam()).copyWith(
        page: event.pageNumber,
        limit: _pageSize,
      );

      final result = await _tourRepository.getTours(params);
      final tours = result.tours ?? [];
      final pagination = result.pagination;

      final isLastPage = pagination != null ? event.pageNumber >= pagination.totalPages : tours.length < _pageSize;

      emit(
        current.copyWith(
          isLoading: false,
          error: null,
          hasNextPage: !isLastPage,
          pages: [...?current.pages, tours],
          keys: [...?current.keys, event.pageNumber],
        ),
      );
    } on Object catch (e) {
      emit(
        current.copyWith(
          isLoading: false,
          error: e,
        ),
      );
    }
  }

  Future<void> _onRefresh(
    ToursRefresh event,
    Emitter<ToursState> emit,
  ) async {
    emit(
      ToursState(
        params: state.params,
        isLoading: true,
        hasNextPage: true,
      ),
    );

    try {
      final params = (state.params ?? const ToursParam()).copyWith(
        page: 1,
        limit: _pageSize,
      );

      final result = await _tourRepository.getTours(params);
      final tours = result.tours ?? [];
      final pagination = result.pagination;

      final isLastPage = tours.length < _pageSize || (pagination != null && pagination.totalPages <= 1);

      emit(
        ToursState(
          params: state.params,
          isLoading: false,
          hasNextPage: !isLastPage,
          pages: [tours],
          keys: const [1],
        ),
      );
    } on Object catch (e) {
      emit(
        ToursState(
          params: state.params,
          isLoading: false,
          error: e,
          hasNextPage: false,
        ),
      );
    }
  }

  Future<void> _onFilterChanged(
    ToursFilterChanged event,
    Emitter<ToursState> emit,
  ) async {
    emit(
      ToursState(
        params: event.params,
        isLoading: true,
        hasNextPage: true,
      ),
    );

    try {
      final params = event.params.copyWith(
        page: 1,
        limit: _pageSize,
      );

      final result = await _tourRepository.getTours(params);
      final tours = result.tours ?? [];
      final pagination = result.pagination;

      final isLastPage = tours.length < _pageSize || (pagination != null && pagination.totalPages <= 1);

      emit(
        ToursState(
          params: event.params,
          isLoading: false,
          hasNextPage: !isLastPage,
          pages: [tours],
          keys: const [1],
        ),
      );
    } on Object catch (e) {
      emit(
        ToursState(
          params: event.params,
          isLoading: false,
          error: e,
          hasNextPage: false,
        ),
      );
    }
  }
}
