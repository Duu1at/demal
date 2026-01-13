import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tour_repository/tour_repository.dart';

class TourLocationSection extends StatelessWidget {
  const TourLocationSection(this.tour, {super.key});
  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.gatheringPlace, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(tour.meetingPoint?.address ?? '', style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
