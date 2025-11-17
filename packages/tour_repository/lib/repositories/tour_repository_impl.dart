import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class TourRepositoryImpl implements TourRepository {
  const TourRepositoryImpl(this.tourRemoteDataSource);

  final TourRemoteDataSource tourRemoteDataSource;

  @override
  Future<TourModel> createTour(TourCreateParam param) {
    return tourRemoteDataSource.createTour(param);
  }

  @override
  Future<TourReviewModel> createTourReview(CreateTourReviewParam param) {
    return tourRemoteDataSource.createTourReview(param);
  }

  @override
  Future<void> deleteTour(String tourId) {
    return tourRemoteDataSource.deleteTour(tourId);
  }

  @override
  Future<ToursModel> getPartnerTours(int page, int limit) {
    return tourRemoteDataSource.getPartnerTours(page, limit);
  }

  @override
  Future<TourModel> getTourDetail(String tourId) {
    return tourRemoteDataSource.getTourDetail(tourId);
  }

  @override
  Future<ToursReviewsModel> getTourReviews(String tourId, int page, int limit) {
    return tourRemoteDataSource.getTourReviews(tourId, page, limit);
  }

  @override
  Future<ToursModel> getTours(ToursParam? params) {
    return tourRemoteDataSource.getTours(params);
  }

  @override
  Future<TourModel> updateTour(String tourId, TourUpdateParam param) {
    return tourRemoteDataSource.updateTour(tourId, param);
  }
}
