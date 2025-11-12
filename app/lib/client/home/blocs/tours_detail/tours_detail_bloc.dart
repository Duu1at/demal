import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_repository/tour_repository.dart';

part 'tours_detail_event.dart';
part 'tours_detail_state.dart';

class ToursDetailBloc extends Bloc<ToursDetailEvent, ToursDetailState> {
  ToursDetailBloc(this._tourRepository) : super(const ToursDetailInitial()) {
    on<ToursDetailEvent>(_onToursDetailEvent);
  }

  final TourRepository _tourRepository;

  Future<void> _onToursDetailEvent(
    ToursDetailEvent event,
    Emitter<ToursDetailState> emit,
  ) async {
    try {
      emit(const ToursDetailLoading());
      final result = await _tourRepository.getClientTourDetail(event.tourId);
      emit(ToursDetailSuccess(result));
    } on Object catch (e) {
      emit(ToursDetailError(e));
    }
  }
}
