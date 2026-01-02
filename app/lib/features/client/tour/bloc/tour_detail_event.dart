part of 'tour_detail_bloc.dart';

final class TourDetailEvent extends Equatable {
  const TourDetailEvent(this.tourId);
  final String? tourId;

  @override
  List<Object?> get props => [tourId];
}
