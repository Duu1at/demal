import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:meta/meta.dart';

@immutable
abstract interface class ClientTourRepository {
  Future<List<ToursModel>> getTours(ToursParams params);
  Future<TourDetailModel> getTourDetail(String tourId);
}
