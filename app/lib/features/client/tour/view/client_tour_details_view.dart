import 'package:app/app/app.dart';
import 'package:app/app/router/navigation_helper.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_repository/tour_repository.dart';

class ClientTourDetailsView extends StatelessWidget {
  const ClientTourDetailsView(this.tourId, {super.key});
  final String? tourId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TourDetailBloc(context.read<TourRepository>())..add(TourDetailEvent(tourId)),
      child: ClientTourDetailsViewBody(tourId),
    );
  }
}

class ClientTourDetailsViewBody extends StatefulWidget {
  const ClientTourDetailsViewBody(this.tourId, {super.key});
  final String? tourId;

  @override
  State<ClientTourDetailsViewBody> createState() => _ClientTourDetailsViewBodyState();
}

class _ClientTourDetailsViewBodyState extends State<ClientTourDetailsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<TourDetailBloc, TourDetailState>(
        builder: (context, state) {
          return switch (state) {
            TourDetailInitial() => const TourDetailLoadingWidget(),
            TourDetailLoading() => const TourDetailLoadingWidget(),
            TourDetailSuccess(tour: final tour) => TourDetailSuccessWidget(tour),
            TourDetailError(error: final error) => TourDetailErrorWidget(error),
          };
        },
      ),
      floatingActionButton: AppButton(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        onPressed: () => context.goNamedIfAuthenticated(AppRouteNames.clientBookingDetails),
        child: Text(context.l10n.bookTour),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
