import 'package:client_tour_repository/src/models/tour_detail_model.dart';
import 'package:client_tour_repository/src/models/tours_model.dart';
import 'package:client_tour_repository/src/repositories/client_tour_repository.dart';
import 'package:meta/meta.dart';

@immutable
final class ClientTourRepositoryMockImpl implements ClientTourRepository {
  @override
  Future<TourDetailModel> getTourDetail(tourid) async {
    return const TourDetailModel();
  }

  @override
  Future<List<ToursModel>> getTours(params) async {
    return const [
      ToursModel(
        id: '1',
        name: 'Tour 1',
        description: 'Description 1',
        image: 'image1.jpg',
        location: 'Location 1',
      ),
      ToursModel(
        id: '2',
        name: 'Tour 2',
        description: 'Description 2',
        image: 'image2.jpg',
        location: 'Location 2',
      ),
    ];
  }
}
