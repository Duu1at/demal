import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tour_repository/tour_repository.dart';

part 'partner_tours_event.dart';
part 'partner_tours_state.dart';

const int _tourLimit = 20;

class PartnerToursBloc extends Bloc<PartnerToursEvent, PartnerToursState> {
  PartnerToursBloc(this._tourRepository) : super(PartnerToursState()) {
    on<PartnerToursFetchEvent>(_onFetch);
    on<PartnerToursRefreshEvent>(_onRefresh);
    on<PartnerToursPagingCancel>(_onPagingCancel);
  }

  final TourRepository _tourRepository;

  Future<void> _onFetch(
    PartnerToursFetchEvent event,
    Emitter<PartnerToursState> emit,
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
      final result = await _tourRepository.getPartnerTours(pageKey, _tourLimit);

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

  Future<void> _onRefresh(
    PartnerToursRefreshEvent event,
    Emitter<PartnerToursState> emit,
  ) async {
    emit(state.reset());
    add(const PartnerToursFetchEvent());
  }

  Future<void> _onPagingCancel(
    PartnerToursPagingCancel event,
    Emitter<PartnerToursState> emit,
  ) async {
    emit(state.copyWith(isLoading: false));
  }

  @override
  Future<void> close() {
    add(const PartnerToursPagingCancel());
    return super.close();
  }
}
