import 'package:api_client/api_client.dart';
import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:meta/meta.dart';

@immutable
final class ClientTourRemoteDataSource {
  const ClientTourRemoteDataSource(this.client);
  final ApiClient client;

  Future<ToursModel> getTours(ToursParams params) {
    final queryParams = params.toJson()..removeWhere((key, value) => value == null);

    return client.getType(
      '/api/v1/tours',
      params: GetApiParams(queryParameters: queryParams),
      fromJson: ToursModel.fromJson,
    );
  }

  Future<TourDetailModel> getToursDetail(String tourId) {
    return client.getType(
      '/api/v1/tours/$tourId',
      fromJson: TourDetailModel.fromJson,
    );
  }
}
