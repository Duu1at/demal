import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
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

    return GestureDetector(
      onTap: () {
        context.goNamed(AppRouter.partnerToursBookings, extra: tour);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.06),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: PartnerTourCardImage(
                tour: tour,
                cacheManager: cacheManager,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PartnerTourCardHeader(
                    title: tour.title,
                    status: tour.status,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (tour.date != null) ...[
                    PartnerTourCardInfoRow(
                      icon: Icons.calendar_today,
                      text: tour.date!,
                    ),
                  ],
                  if (tour.location != null)
                    PartnerTourCardInfoRow(
                      icon: Icons.location_on,
                      text: tour.location!,
                    ),
                  if (tour.availableSpots != null) ...[
                    PartnerTourCardParticipants(
                      totalSpots: tour.availableSpots!,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xs),
                  PartnerTourCardEditButton(tour: tour),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
