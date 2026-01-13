import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:tour_repository/tour_repository.dart';

class TourDetailSuccessWidget extends StatelessWidget {
  const TourDetailSuccessWidget(this.tour, {super.key});
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
