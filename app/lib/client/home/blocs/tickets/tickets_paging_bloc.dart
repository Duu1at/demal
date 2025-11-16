import 'package:app/client/home/blocs/paging/paging_bloc.dart';
import 'package:bookings_repository/bookings_repository.dart';

/// BLoC для пагинации билетов
///
/// Использует `void` для параметров, так как getMyTickets принимает только pageKey
class TicketsPagingBloc extends PagingBloc<BookingModel, void> {
  TicketsPagingBloc({
    required BookingsRepository bookingsRepository,
  }) : super(
         fetchFn: (int pageKey, void params) async {
           final response = await bookingsRepository.getMyTickets(pageKey);
           return response.bookings;
         },
       );
}
