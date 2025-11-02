import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:app/client/home/blocs/tours/tours_constants.dart';

/// Event transformers для ToursBloc
class ToursEventTransformer {
  ToursEventTransformer._();

  /// Throttle transformer для предотвращения слишком частых событий
  static EventTransformer<E> throttleDroppable<E>() {
    return (events, mapper) {
      return droppable<E>().call(
        events.throttle(ToursConstants.throttleDuration),
        mapper,
      );
    };
  }

  /// Debounce transformer для поиска (ждать окончания ввода)
  static EventTransformer<E> debounceDroppable<E>() {
    return (events, mapper) {
      return droppable<E>().call(
        events.debounce(ToursConstants.debounceDuration),
        mapper,
      );
    };
  }
}

