import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:core/network/remote_client.dart';
import 'package:meta/meta.dart';

@immutable
final class ClientTourRemoteDataSource {
  const ClientTourRemoteDataSource(this.client);
  final RemoteClient client;

  Future<List<ToursModel>> getTours(ToursParams params) async {
    final result = await client.get<Map<String, dynamic>>(
      '/api/v1/tours',
      queryParameters: params.toJson(),
    );

    final tours = result['data']
        .map(
          (entry) => ToursModel.fromJson(entry.value as Map<String, dynamic>),
        )
        .toList();

    return tours;
  }

  Future<TourDetailModel> getToursDetail(String tourId) async {
    final result = await client.get<TourDetailModel>(
      '/api/v1/tours/$tourId',
      fromJson: (json) => TourDetailModel.fromJson(json),
    );
    return result;
  }
}
