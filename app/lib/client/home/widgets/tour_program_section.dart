import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:tour_repository/tour_repository.dart';

class TourProgramSection extends StatelessWidget {
  const TourProgramSection(this.tour, {super.key});
  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var count = 1;
    final program = tour.program ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Программа тура', style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        ...program.entries.map(
          (entry) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
              child: Text('${count++}'),
            ),
            title: Text(
              entry.key,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(entry.value, style: theme.textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }
}
