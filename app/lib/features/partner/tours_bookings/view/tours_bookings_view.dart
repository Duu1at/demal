import 'package:app/core/exceptions/exception.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_repository/tour_repository.dart';

class ToursBookingsView extends StatelessWidget {
  const ToursBookingsView(this.tour, {super.key});

  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToursBookingsCubit(context.read<TourRepository>())..fetchToursBookings(tour.tourId ?? ''),
      child: ToursBookingsViewBody(tour),
    );
  }
}

class ToursBookingsViewBody extends StatelessWidget {
  const ToursBookingsViewBody(this.tour, {super.key});
  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(tour.title ?? ''),
        centerTitle: true,
      ),
      body: BlocBuilder<ToursBookingsCubit, ToursBookingsState>(
        builder: (context, state) {
          return switch (state) {
            ToursBookingsInitial() || ToursBookingsLoading() => const Center(child: CircularProgressIndicator()),
            ToursBookingsSuccess(bookings: final bookings) => ToursBookingsListContent(bookings),
            ToursBookingsError(error: final error) => ErrorBodyWidget(error),
          };
        },
      ),
    );
  }
}
