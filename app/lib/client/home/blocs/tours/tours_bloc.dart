import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/client/home/blocs/tours/tours_constants.dart';
import 'package:app/client/home/blocs/tours/tours_event_transformer.dart';

part 'tours_event.dart';
part 'tours_state.dart';

class ToursBloc extends Bloc<ToursEvent, ToursState> {
  ToursBloc(this._clientTourRepository) : super(const ToursState()) {
    on<ToursInitialFetchEvent>(_onToursInitialFetchEvent);
    on<ToursRefreshEvent>(
      _onToursRefreshEvent,
      transformer: ToursEventTransformer.throttleDroppable(),
    );
    on<ToursLoadMoreEvent>(
      _onToursLoadMoreEvent,
      transformer: ToursEventTransformer.throttleDroppable(),
    );
    on<ToursFilterChangedEvent>(
      _onToursFilterChangedEvent,
      transformer: ToursEventTransformer.debounceDroppable(),
    );
  }

  final ClientTourRepository _clientTourRepository;

  Future<void> _onToursInitialFetchEvent(
    ToursInitialFetchEvent event,
    Emitter<ToursState> emit,
  ) async {
    if (state.tours.isNotEmpty) return;

    emit(state.copyWith(status: ToursStatus.loading));

    try {
      const params = ToursParams(page: 1, limit: ToursConstants.tourLimit);
      final result = await _clientTourRepository.getTours(params);

      emit(
        state.copyWith(
          status: ToursStatus.success,
          tours: result.tours ?? [],
          pagination: result.pagination,
          params: params,
          currentPage: 1,
          hasReachedMax: result.tours?.isEmpty ?? true,
          clearException: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ToursStatus.failure, exception: e));
    }
  }

  Future<void> _onToursRefreshEvent(
    ToursRefreshEvent event,
    Emitter<ToursState> emit,
  ) async {
    if (state.status == ToursStatus.loading && !state.isRefreshing) {
      return;
    }

    emit(state.copyWith(isRefreshing: true, status: ToursStatus.loading));

    try {
      final params =
          event.params ??
          state.params?.copyWith(page: 1, limit: ToursConstants.tourLimit) ??
          const ToursParams(page: 1, limit: ToursConstants.tourLimit);

      final result = await _clientTourRepository.getTours(params);

      emit(
        state.copyWith(
          status: ToursStatus.success,
          tours: result.tours ?? [],
          pagination: result.pagination,
          params: params,
          currentPage: 1,
          hasReachedMax: result.tours?.isEmpty ?? true,
          isRefreshing: false,
          clearException: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ToursStatus.failure,
          exception: e,
          isRefreshing: false,
        ),
      );
    }
  }

  Future<void> _onToursLoadMoreEvent(
    ToursLoadMoreEvent event,
    Emitter<ToursState> emit,
  ) async {
    // Защита от множественных запросов
    if (state.status == ToursStatus.loading || !state.canLoadMore) {
      return;
    }

    // Дополнительная проверка на валидность следующей страницы
    if (state.pagination != null) {
      final nextPage = state.currentPage + 1;
      if (nextPage > state.pagination!.totalPages) {
        emit(state.copyWith(hasReachedMax: true));
        return;
      }
    }

    emit(state.copyWith(status: ToursStatus.loading));

    try {
      final nextPage = state.currentPage + 1;
      final params = (state.params ?? const ToursParams()).copyWith(
        page: nextPage,
        limit: ToursConstants.tourLimit,
      );

      final result = await _clientTourRepository.getTours(params);

      // Проверка на пустой результат
      if (result.tours == null || result.tours!.isEmpty) {
        emit(state.copyWith(status: ToursStatus.success, hasReachedMax: true));
        return;
      }

      final newTours = result.tours ?? [];
      final allTours = [...state.tours, ...newTours];

      // Проверка достижения максимального количества страниц
      final pagination = result.pagination;
      final hasReachedMax = pagination != null
          ? nextPage >= pagination.totalPages
          : newTours.length < ToursConstants.tourLimit;

      emit(
        state.copyWith(
          status: ToursStatus.success,
          tours: allTours,
          pagination: pagination,
          currentPage: nextPage,
          hasReachedMax: hasReachedMax,
          clearException: true,
        ),
      );
    } catch (e) {
      // При ошибке загрузки следующей страницы не сбрасываем список
      emit(state.copyWith(status: ToursStatus.failure, exception: e));
    }
  }

  Future<void> _onToursFilterChangedEvent(
    ToursFilterChangedEvent event,
    Emitter<ToursState> emit,
  ) async {
    emit(state.copyWith(status: ToursStatus.loading, isRefreshing: true));

    try {
      final params = event.params.copyWith(
        page: 1,
        limit: ToursConstants.tourLimit,
      );

      final result = await _clientTourRepository.getTours(params);

      emit(
        state.copyWith(
          status: ToursStatus.success,
          tours: result.tours ?? [],
          pagination: result.pagination,
          params: params,
          currentPage: 1,
          hasReachedMax: result.tours?.isEmpty ?? true,
          isRefreshing: false,
          clearTours: true,
          clearException: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ToursStatus.failure,
          exception: e,
          isRefreshing: false,
        ),
      );
    }
  }
}
