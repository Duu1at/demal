import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class TourRemoteDataSource {
  const TourRemoteDataSource(this.client);
  final ApiClient client;

  Future<ToursModel> getTours(ToursParam? params) {
    return client.getType<ToursModel>(
      '/api/v1/tours',
      params: GetApiParams(queryParameters: params?.toJson()),
      fromJson: ToursModel.fromJson,
    );
  }

  Future<ToursBookingsModel> getBookingsTours(String tourId) async {
    return client.getType<ToursBookingsModel>(
      '/api/v1/tours/$tourId/bookings',
      fromJson: ToursBookingsModel.fromJson,
    );
  }

  Future<TourModel> getTourDetail(String tourId) async {
    final response = await client.getResponse<Map<String, dynamic>>(
      '/api/v1/tours/$tourId',
    );
    return TourModel.fromJson(response.data?['tour'] as Map<String, dynamic>);
  }

  Future<TourReviewModel> createTourReview(CreateTourReviewParam param) async {
    final response = await client.postResponse<Map<String, dynamic>>(
      '/api/v1/reviews',
      data: param.toJson(),
    );
    return TourReviewModel.fromJson(response.data?['review'] as Map<String, dynamic>);
  }

  Future<ToursReviewsModel> getTourReviews(String tourId, int page, int limit) async {
    return client.getType<ToursReviewsModel>(
      '/api/v1/tours/$tourId/reviews',
      params: GetApiParams(
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      ),
      fromJson: ToursReviewsModel.fromJson,
    );
  }

  Future<TourModel> createTour(TourCreateParam param) async {
    final response = await client.postResponse<Map<String, dynamic>>(
      '/api/v1/tours',
      data: param.toJson(),
    );
    return TourModel.fromJson(response.data?['tour'] as Map<String, dynamic>);
  }

  Future<ToursModel> getPartnerTours(int page, int limit) async {
    return client.getType<ToursModel>(
      '/api/v1/tours/my',
      params: GetApiParams(
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      ),
      fromJson: ToursModel.fromJson,
    );
  }

  Future<TourModel> updateTour(String tourId, TourUpdateParam param) async {
    final response = await client.putResponse<Map<String, dynamic>>(
      '/api/v1/tours/$tourId',
      data: param.toJson(),
    );
    return TourModel.fromJson(response.data?['tour'] as Map<String, dynamic>);
  }

  Future<void> deleteTour(String tourId) async {
    await client.delete<void>('/api/v1/tours/$tourId');
  }
}
