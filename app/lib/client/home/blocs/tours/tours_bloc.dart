import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tours_event.dart';
part 'tours_state.dart';

class ToursBloc extends Bloc<ToursEvent, ToursState> {
  ToursBloc(this._clientTourRepository) : super(const ToursState()) {
    on<ToursFetchEvent>(_onToursFetchEvent);
  }

  final ClientTourRepository _clientTourRepository;

  Future<void> _onToursFetchEvent(
    ToursFetchEvent event,
    Emitter<ToursState> emit,
  ) async {
    try {
      if (state.hasReachedMax) return;
      emit(state.copyWith(status: ToursStatus.loading));
      final result = await _clientTourRepository.getTours(event.params);
      emit(state.copyWith(status: ToursStatus.success, tours: result));
    } catch (e) {
      emit(state.copyWith(status: ToursStatus.failure, exception: e));
    }
  }
}
