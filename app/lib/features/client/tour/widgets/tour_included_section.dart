import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tour_repository/tour_repository.dart';

class TourIncludedSection extends StatelessWidget {
  const TourIncludedSection(this.tour, {super.key});
  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final included = tour.whatsIncluded ?? [];
    final notIncluded = tour.whatsNotIncluded ?? [];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.whatIsIncluded, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              ...included.map((item) => _buildRow(context, item, true)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.whatIsNotIncluded, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              ...notIncluded.map((item) => _buildRow(context, item, false)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, String text, bool included) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            included ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 20,
            color: included ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
