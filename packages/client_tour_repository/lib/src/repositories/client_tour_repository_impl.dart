import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:meta/meta.dart';

@immutable
final class ClientTourRepositoryImpl implements ClientTourRepository {
  const ClientTourRepositoryImpl(this.clientTourRemoteDataSource);

  final ClientTourRemoteDataSource clientTourRemoteDataSource;

  @override
  Future<TourDetailModel> getTourDetail(String tourId) async {
    try {
      final result = await clientTourRemoteDataSource.getToursDetail(tourId);
      return result;
    } catch (e, s) {
      throw ClientTourException(e, s);
    }
  }

  @override
  Future<ToursModel> getTours(ToursParams params) async {
    try {
      final result = await clientTourRemoteDataSource.getTours(params);
      return result;
    } catch (e, s) {
      throw ClientTourException(e, s);
    }
  }
}
