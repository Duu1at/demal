import 'package:bookings_repository/bookings_repository.dart';

abstract class BookingsRepository {
  Future<CreateBookingsModel> createBookings(CreateBookingsParam param);
  Future<List<MyBookingsModel>> getMyBookings(int page, int limit);
  Future<BookingCancelModel> cancelBooking(String bookingId);
  Future<BookingPaymentConfirmModel> confirmBookingPayment(String bookingId);
}
