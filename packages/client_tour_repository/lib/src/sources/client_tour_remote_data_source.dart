import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:core/network/remote_client.dart';
import 'package:meta/meta.dart';

@immutable
final class ClientTourRemoteDataSource {
  const ClientTourRemoteDataSource(this.client);
  final RemoteClient client;

  Future<ToursModel> getTours(ToursParams params) async {
    final queryParams = params.toJson()..removeWhere((key, value) => value == null);

    final result = await client.get<ToursModel>(
      '/api/v1/tours',
      queryParameters: queryParams,
      fromJson: ToursModel.fromJson,
    );

    return result;
  }

  Future<TourDetailModel> getToursDetail(String tourId) async {
    final result = await client.get<TourDetailModel>(
      '/api/v1/tours/$tourId',
      fromJson: TourDetailModel.fromJson,
    );
    return result;
  }
}
