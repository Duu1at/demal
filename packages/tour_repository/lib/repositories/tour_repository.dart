import 'package:meta/meta.dart';

import 'package:tour_repository/tour_repository.dart';

@immutable
abstract interface class TourRepository {
  Future<ToursModel> getClientTours(ToursParams params);
  Future<TourModel> getClientTourDetail(String tourId);
  Future<TourDetailModel> getClientTourTickets(int page, int limit);

  Future<void> getTourReviews(String tourId, int page, int limit);
  Future<void> createTourReview(CreateTourReviewParam createTourReviewParam);

  Future<void> createPartnerTour(TourCreateParam tourCreateParam);
  Future<void> getPartnerTours(ToursParams params);
  Future<void> updatePartnerTour(String tourId, TourCreateParam tourCreateParam);
  Future<void> deletePartnerTour(String tourId);
}
