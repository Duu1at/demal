import 'package:app/utils/image_storage/image_storage.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tour_repository/tour_repository.dart';

class TourOrganizerTile extends StatelessWidget {
  const TourOrganizerTile(this.tour, {super.key});
  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        AvatarIcon(
          imageUrl: tour.organizer?.imageUrl ?? '',
          cacheManager: ImageStorage.instance.avatarManager,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tour.organizer?.fullName ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                context.l10n.tourOrganizer,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TourOrganizerTileShimmer extends StatelessWidget {
  const TourOrganizerTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ShimmerContainer(width: 52, height: 52, radius: 26),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerContainer(width: 160, height: 20),
              SizedBox(height: 8),
              ShimmerContainer(width: 100, height: 14),
            ],
          ),
        ),
      ],
    );
  }
}
