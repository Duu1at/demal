import 'package:meta/meta.dart';

import 'package:tour_repository/tour_repository.dart';

@immutable
abstract interface class TourRepository {
  /// Get tours for client
  Future<ToursModel> getTours(ToursParam? params);
  Future<TourModel> getTourDetail(String tourId);

  /// Get reviews for a tour
  Future<ToursReviewsModel> getTourReviews(String tourId, int page, int limit);
  Future<TourReviewModel> createTourReview(CreateTourReviewParam param);

  /// Get tours for partner
  Future<ToursBookingsModel> getBookingsTours(String tourId);
  Future<TourModel> createTour(TourCreateParam param);
  Future<ToursModel> getPartnerTours(int page, int limit);
  Future<TourModel> updateTour(String tourId, TourUpdateParam param);
  Future<void> deleteTour(String tourId);
}
