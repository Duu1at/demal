part of 'tours_bookings_cubit.dart';

sealed class ToursBookingsState extends Equatable {
  const ToursBookingsState();

  @override
  List<Object> get props => [];
}

final class ToursBookingsInitial extends ToursBookingsState {}

final class ToursBookingsLoading extends ToursBookingsState {
  const ToursBookingsLoading();
}

final class ToursBookingsSuccess extends ToursBookingsState {
  const ToursBookingsSuccess(this.bookings);
  final ToursBookingsModel bookings;
}

final class ToursBookingsError extends ToursBookingsState {
  const ToursBookingsError(this.error);
  final Object error;
}
