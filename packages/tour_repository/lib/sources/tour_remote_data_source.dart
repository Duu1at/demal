import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class TourRemoteDataSource {
  const TourRemoteDataSource(this.client);
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
