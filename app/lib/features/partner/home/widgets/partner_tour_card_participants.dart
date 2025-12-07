import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PartnerTourCardParticipants extends StatelessWidget {
  const PartnerTourCardParticipants({
    required this.totalSpots,
    this.bookedSpots = 0,
    super.key,
  });

  final int totalSpots;
  final int bookedSpots;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final availableSpots = totalSpots - bookedSpots;
    final fillPercentage = totalSpots > 0 ? bookedSpots / totalSpots : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.people_outline,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '$bookedSpots / $totalSpots мест',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (availableSpots > 0) ...[
              const Spacer(),
              _AvailableSpotsBadge(
                availableSpots: availableSpots,
                theme: theme,
              ),
            ],
          ],
        ),
        if (totalSpots > 0) ...[
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fillPercentage,
              minHeight: 4,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressColor(theme, fillPercentage),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _getProgressColor(ThemeData theme, double percentage) {
    if (percentage > 0.8) {
      return theme.colorScheme.error;
    } else if (percentage > 0.5) {
      return theme.colorScheme.tertiary;
    } else {
      return theme.colorScheme.primary;
    }
  }
}

class _AvailableSpotsBadge extends StatelessWidget {
  const _AvailableSpotsBadge({
    required this.availableSpots,
    required this.theme,
  });

  final int availableSpots;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$availableSpots свободно',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
