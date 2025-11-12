import 'package:meta/meta.dart';

import 'package:tour_repository/tour_repository.dart';

@immutable
abstract interface class TourRepository {
  Future<ToursModel> getTours(ToursParams params);
  Future<TourDetailModel> getTourDetail(String tourId);
}
