import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_repository/tour_repository.dart';

part 'tours_bookings_state.dart';

class ToursBookingsCubit extends Cubit<ToursBookingsState> {
  ToursBookingsCubit(this.tourRepository) : super(ToursBookingsInitial());

  final TourRepository tourRepository;

  Future<void> fetchToursBookings(String tourId) async {
    if (state is ToursBookingsLoading) return;
    emit(const ToursBookingsLoading());
    try {
      final result = await tourRepository.getBookingsTours(tourId);
      emit(ToursBookingsSuccess(result));
    } on Object catch (e) {
      emit(ToursBookingsError(e));
    }
  }
}
