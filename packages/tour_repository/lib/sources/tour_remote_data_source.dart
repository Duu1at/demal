import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class TourRemoteDataSource {
  const TourRemoteDataSource(this.client);
  final ApiClient client;

  Future<ToursModel> getTours(ToursParam params) {
    final queryParams = params.toJson()..removeWhere((key, value) => value == null);

    return client.getType(
      '/api/v1/tours',
      params: GetApiParams(queryParameters: queryParams),
      fromJson: ToursModel.fromJson,
    );
  }

  Future<TourModel> getToursDetail(String tourId) async {
    final response = await client.getResponse<Map<String, dynamic>>(
      '/api/v1/tours/$tourId',
    );
    return TourModel.fromJson(response.data?['tour'] as Map<String, dynamic>);
  }
}
