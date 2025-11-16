import 'package:api_client/api_client.dart';
import 'package:bookings_repository/bookings_repository.dart';

final class BookingRemoteDataSource {
  BookingRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<CreateBookingsModel> createBookings(CreateBookingsParam param) {
    return _apiClient.postType<CreateBookingsModel>(
      'api/v1/bookings',
      data: param.toJson(),
      fromJson: CreateBookingsModel.fromJson,
    );
  }

  Future<MyBookingsModel> getMyTickets(int page) {
    return _apiClient.getType<MyBookingsModel>(
      'api/v1/bookings/me?page=$page&limit=20',
      fromJson: MyBookingsModel.fromJson,
    );
  }

  Future<BookingCancelModel> cancelBooking(String bookingId) {
    return _apiClient.postType<BookingCancelModel>(
      'api/v1/bookings/$bookingId',
      fromJson: BookingCancelModel.fromJson,
    );
  }

  Future<BookingPaymentConfirmModel> confirmBookingPayment(String bookingId) {
    return _apiClient.postType<BookingPaymentConfirmModel>(
      'api/v1/bookings/$bookingId/confirm-payment',
      fromJson: BookingPaymentConfirmModel.fromJson,
    );
  }
}
