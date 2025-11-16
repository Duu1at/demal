part of 'tours_detail_bloc.dart';

final class ToursDetailEvent extends Equatable {
  const ToursDetailEvent(this.tourId);
  final String tourId;

  @override
  List<Object> get props => [tourId];
}
