import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

sealed class PagingEvent {
  const PagingEvent();
}

final class PagingFetchNext extends PagingEvent {
  const PagingFetchNext();
}

final class PagingRefresh extends PagingEvent {
  const PagingRefresh();
}

final class PagingChangeSearch extends PagingEvent {
  const PagingChangeSearch(this.search);

  final String? search;
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
    this.search,
    this.params,
  });

  final String? search;
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
    params: params,
  );

  @override
  bool operator ==(Object other) => other is BlocPagingState<T, P> && super == other && params == other.params;

  @override
  int get hashCode => Object.hash(
    super.hashCode,
    params,
  );
}

/// Универсальный BLoC для пагинации
///
/// [T] - тип элементов в списке
/// [P] - тип параметров (может быть `void` если параметры не нужны)
///
/// Использование:
/// ```dart
/// // Без параметров
/// class MyPagingBloc extends PagingBloc<MyModel, void> {
///   MyPagingBloc() : super(
///     fetchFn: (pageKey, params) async {
///       final response = await repository.getItems(pageKey);
///       return response.items;
///     },
///   );
/// }
///
/// // С параметрами
/// class ToursPagingBloc extends PagingBloc<TourModel, ToursParam> {
///   ToursPagingBloc() : super(
///     fetchFn: (pageKey, params) async {
///       final response = await repository.getTours(params?.copyWith(page: pageKey));
///       return response.tours ?? [];
///     },
///   );
/// }
/// ```
class PagingBloc<T, P> extends Bloc<PagingEvent, BlocPagingState<T, P>> {
  PagingBloc({
    required this.fetchFn,
    this.isLastPageFn,
  }) : super(BlocPagingState<T, P>()) {
    on<PagingFetchNext>(_onFetchNext);
    on<PagingRefresh>(_onRefresh);
    on<PagingChangeSearch>(_onChangeSearch);
    on<PagingChangeParams<P>>(_onChangeParams);
  }

  /// Функция для загрузки данных
  ///
  /// Параметры:
  /// - [pageKey] - номер страницы (начинается с 1)
  /// - [params] - параметры для загрузки (может быть null)
  ///
  /// Возвращает список элементов для данной страницы
  final Future<List<T>> Function(int pageKey, P? params) fetchFn;

  /// Опциональная функция для определения последней страницы
  ///
  /// По умолчанию: страница считается последней, если результат пустой.
  /// Можно переопределить для более сложной логики (например, проверка totalPages из API).
  final bool Function(List<T> result, int pageKey)? isLastPageFn;

  /// Обработчик загрузки следующей страницы
  Future<void> _onFetchNext(
    PagingFetchNext event,
    Emitter<BlocPagingState<T, P>> emit,
  ) async {
    final current = state;

    // Проверка: уже загружается или нет следующих страниц
    if (current.isLoading || !current.hasNextPage) return;

    // Определяем номер следующей страницы
    final pageKey = current.lastPageIsEmpty ? null : current.nextIntPageKey;

    if (pageKey == null) {
      emit(current.copyWith(hasNextPage: false));
      return;
    }

    // Устанавливаем состояние загрузки
    emit(
      current.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      // Загружаем данные
      final result = await fetchFn(pageKey, current.params);

      // Определяем, последняя ли это страница
      final isLastPage = isLastPageFn?.call(result, pageKey) ?? result.isEmpty;

      // Сохраняем результат
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          hasNextPage: !isLastPage,
          pages: [...?state.pages, result],
          keys: [...?state.keys, pageKey],
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, error: e));
    }
  }

  /// Обработчик обновления данных
  Future<void> _onRefresh(
    PagingRefresh event,
    Emitter<BlocPagingState<T, P>> emit,
  ) async {
    emit(state.reset());
    add(const PagingFetchNext());
  }

  /// Обработчик изменения поискового запроса (для обратной совместимости)
  ///
  /// Работает только если P == String?, иначе игнорируется
  Future<void> _onChangeSearch(
    PagingChangeSearch event,
    Emitter<BlocPagingState<T, P>> emit,
  ) async {
    // Для обратной совместимости: если параметры не используются, просто обновляем
    emit(state.reset());
    add(const PagingFetchNext());
  }

  /// Обработчик изменения параметров
  Future<void> _onChangeParams(
    PagingChangeParams<P> event,
    Emitter<BlocPagingState<T, P>> emit,
  ) async {
    emit(state.reset().copyWith(params: event.params));
    add(const PagingFetchNext());
  }
}
