import 'package:app/app/router/app_router.dart';
import 'package:app/features/client/home/blocs/blocs.dart';
import 'package:app/features/client/home/widgets/tour_description_section.dart';
import 'package:app/features/client/home/widgets/tour_header_section.dart';
import 'package:app/features/client/home/widgets/tour_image_carousel.dart';
import 'package:app/features/client/home/widgets/tour_included_section.dart';
import 'package:app/features/client/home/widgets/tour_location_section.dart';
import 'package:app/features/client/home/widgets/tour_organizer_tile.dart';
import 'package:app/features/client/home/widgets/tour_program_section.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';

class ClientTourDetailsView extends StatelessWidget {
  const ClientTourDetailsView(this.tourId, {super.key});
  final String tourId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToursDetailBloc(context.read<TourRepository>())..add(ToursDetailEvent(tourId)),
      child: ClientTourDetailsViewBody(tourId),
    );
  }
}

class ClientTourDetailsViewBody extends StatefulWidget {
  const ClientTourDetailsViewBody(this.tourId, {super.key});
  final String tourId;

  @override
  State<ClientTourDetailsViewBody> createState() => _ClientTourDetailsViewBodyState();
}

class _ClientTourDetailsViewBodyState extends State<ClientTourDetailsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<ToursDetailBloc, ToursDetailState>(
        builder: (context, state) {
          return switch (state) {
            ToursDetailInitial() => const ToursLoadingState(),
            ToursDetailLoading() => const ToursLoadingState(),
            ToursDetailSuccess(tour: final tour) => ToursSuccessState(tour),
            ToursDetailError(error: final error) => ToursErrorState(error),
          };
        },
      ),
      floatingActionButton: AppButton(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        onPressed: () => context.pushNamed(AppRouter.clientBookingDetails),
        child: const Text('Забронировать тур'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ToursLoadingState extends StatelessWidget {
  const ToursLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ToursErrorState extends StatelessWidget {
  const ToursErrorState(this.error, {super.key});
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error.toString()),
    );
  }
}

class ToursSuccessState extends StatelessWidget {
  const ToursSuccessState(this.tour, {super.key});
  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.lg),
                TourHeaderSection(tour),
                const DividerHorisontal(),
                TourOrganizerTile(tour),
                const DividerHorisontal(),
                TourDescriptionSection(tour),
                const DividerHorisontal(),
                TourIncludedSection(tour),
                const DividerHorisontal(),
                TourProgramSection(tour),
                const DividerHorisontal(),
                TourLocationSection(tour),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      stretch: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.40,
      toolbarHeight: 0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground, StretchMode.fadeTitle],
        background: Stack(
          children: [
            TourImageCarousel(tour),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
