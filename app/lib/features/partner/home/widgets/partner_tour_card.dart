import 'package:app/features/partner/home/widgets/partner_tour_card_image.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:tour_repository/tour_repository.dart';

class PartnerTourCard extends StatelessWidget {
  const PartnerTourCard({
    required this.tour,
    this.cacheManager,
    super.key,
  });

  final TourModel tour;
  final CacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PartnerTourCardImage(tour: tour, cacheManager: cacheManager),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tour.title ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (tour.date != null) _buildDateRow(context),
                  const SizedBox(height: AppSpacing.xs),
                  if (tour.availableSpots != null) _buildParticipantsRow(context),
                  const SizedBox(height: AppSpacing.sm),
                  _buildEditButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow(BuildContext context) {
    final theme = Theme.of(context);
    DateTime? date;
    try {
      date = DateTime.parse(tour.date!);
    } on Object catch (_) {}

    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          date != null ? DateFormat('d MMMM yyyy', 'ru').format(date) : tour.date ?? '',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantsRow(BuildContext context) {
    final theme = Theme.of(context);
    final totalSpots = tour.availableSpots ?? 0;
    const bookedSpots = 0;

    return Row(
      children: [
        Icon(
          Icons.people,
          size: 16,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '$bookedSpots / $totalSpots участники',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Редактировать',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
