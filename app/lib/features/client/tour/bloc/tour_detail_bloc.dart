import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_repository/tour_repository.dart';

part 'tour_detail_event.dart';
part 'tour_detail_state.dart';

class TourDetailBloc extends Bloc<TourDetailEvent, TourDetailState> {
  TourDetailBloc(this._tourRepository) : super(const TourDetailInitial()) {
    on<TourDetailEvent>(_onTourDetailEvent);
  }

  final TourRepository _tourRepository;

  Future<void> _onTourDetailEvent(
    TourDetailEvent event,
    Emitter<TourDetailState> emit,
  ) async {
    try {
      emit(const TourDetailLoading());
      final result = await _tourRepository.getTourDetail(event.tourId ?? '');
      emit(TourDetailSuccess(result));
    } on Object catch (e) {
      emit(TourDetailError(e));
    }
  }
}
