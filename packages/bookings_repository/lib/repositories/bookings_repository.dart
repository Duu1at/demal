import 'package:bookings_repository/bookings_repository.dart';

abstract class BookingsRepository {
  Future<CreateBookingsModel> createBookings(CreateBookingsParam param);
  Future<MyBookingsModel> getMyTickets(int page);
  Future<BookingCancelModel> cancelBooking(String bookingId);
  Future<BookingPaymentConfirmModel> confirmBookingPayment(String bookingId);
}
