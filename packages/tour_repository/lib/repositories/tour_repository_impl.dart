import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class TourRepositoryImpl implements TourRepository {
  const TourRepositoryImpl(this.tourRemoteDataSource);

  final TourRemoteDataSource tourRemoteDataSource;

  @override
  Future<TourDetailModel> getClientTourDetail(String tourId) {
    return tourRemoteDataSource.getToursDetail(tourId);
  }

  @override
  Future<ToursModel> getClientTours(ToursParams params) {
    return tourRemoteDataSource.getTours(params);
  }

  @override
  Future<void> createPartnerTour(TourCreateParam tourCreateParam) {
    throw UnimplementedError();
  }

  @override
  Future<void> deletePartnerTour(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<void> getClientTourReviews(String tourId, int page, int limit) {
    throw UnimplementedError();
  }

  @override
  Future<TourDetailModel> getClientTourTickets(int page, int limit) {
    throw UnimplementedError();
  }

  @override
  Future<void> getPartnerTours(ToursParams params) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePartnerTour(String tourId, TourCreateParam tourCreateParam) {
    throw UnimplementedError();
  }
}
