import 'package:api_client/api_client.dart';
import 'package:bookings_repository/bookings_repository.dart';

final class BookingRemoteDataSource {
  BookingRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<CreateBookingsModel> createBookings(CreateBookingsParam param) {
    return _apiClient.postType<CreateBookingsModel>(
      '/bookings',
      data: param.toJson(),
      fromJson: CreateBookingsModel.fromJson,
    );
  }

  Future<List<MyBookingsModel>> getMyBookings(int page, int limit) {
    return _apiClient.getListOfType<MyBookingsModel>(
      '/bookings/me?page=$page&limit=$limit',
      fromJson: MyBookingsModel.fromJson,
    );
  }

  Future<BookingCancelModel> cancelBooking(String bookingId) {
    return _apiClient.postType<BookingCancelModel>(
      '/bookings/$bookingId',
      fromJson: BookingCancelModel.fromJson,
    );
  }

  Future<BookingPaymentConfirmModel> confirmBookingPayment(String bookingId) {
    return _apiClient.postType<BookingPaymentConfirmModel>(
      '/bookings/$bookingId/confirm-payment',
      fromJson: BookingPaymentConfirmModel.fromJson,
    );
  }
}
