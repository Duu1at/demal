

import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class TourRepositoryImpl implements TourRepository {
  const TourRepositoryImpl(this.tourRemoteDataSource);

  final TourRemoteDataSource tourRemoteDataSource;

  @override
  Future<TourDetailModel> getTourDetail(String tourId) {
    return tourRemoteDataSource.getToursDetail(tourId);
  }

  @override
  Future<ToursModel> getTours(ToursParams params) {
    return tourRemoteDataSource.getTours(params);
  }
}
