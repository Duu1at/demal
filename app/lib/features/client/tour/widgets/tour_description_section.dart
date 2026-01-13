import 'package:app/features/client/client.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tour_repository/tour_repository.dart';

class TourDescriptionSection extends StatelessWidget {
  const TourDescriptionSection(this.tour, {super.key});
  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.description,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ExpandableText(text: tour.description ?? ''),
      ],
    );
  }
}
