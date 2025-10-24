import 'package:app/app/router/app_router.dart';
import 'package:app/client/home/widgets/tour_description_section.dart';
import 'package:app/client/home/widgets/tour_header_section.dart';
import 'package:app/client/home/widgets/tour_image_carousel.dart';
import 'package:app/client/home/widgets/tour_included_section.dart';
import 'package:app/client/home/widgets/tour_location_section.dart';
import 'package:app/client/home/widgets/tour_organizer_tile.dart';
import 'package:app/client/home/widgets/tour_program_section.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientTourDetailsView extends StatefulWidget {
  const ClientTourDetailsView({super.key});

  @override
  State<ClientTourDetailsView> createState() => _ClientTourDetailsViewState();
}

class _ClientTourDetailsViewState extends State<ClientTourDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.lg),
                  TourHeaderSection(),
                  DividerHorisontal(),
                  TourOrganizerTile(),
                  DividerHorisontal(),
                  TourDescriptionSection(),
                  DividerHorisontal(),
                  TourIncludedSection(),
                  DividerHorisontal(),
                  TourProgramSection(),
                  DividerHorisontal(),
                  TourLocationSection(),
                  SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AppButton(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        onPressed: () => context.pushNamed(AppRouter.clientBookingDetails),
        child: const Text('Забронировать тур'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            const TourImageCarousel(),
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
