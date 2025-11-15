import 'package:bookings_repository/bookings_repository.dart';

final class BookingRepositoryImpl implements BookingsRepository {
  BookingRepositoryImpl(this._bookingRemoteDataSource);

  final BookingRemoteDataSource _bookingRemoteDataSource;

  @override
  Future<CreateBookingsModel> createBookings(CreateBookingsParam param) {
    return _bookingRemoteDataSource.createBookings(param);
  }

  @override
  Future<List<MyBookingsModel>> getMyBookings(int page, int limit) {
    return _bookingRemoteDataSource.getMyBookings(page, limit);
  }

  @override
  Future<BookingCancelModel> cancelBooking(String bookingId) {
    return _bookingRemoteDataSource.cancelBooking(bookingId);
  }

  @override
  Future<BookingPaymentConfirmModel> confirmBookingPayment(String bookingId) {
    return _bookingRemoteDataSource.confirmBookingPayment(bookingId);
  }
}
