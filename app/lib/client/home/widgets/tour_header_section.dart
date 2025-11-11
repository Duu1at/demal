import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TourHeaderSection extends StatelessWidget {
  const TourHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Flexible(
              child: Text(
                'Saint Martin’s Island',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '2400c',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Assets.icons.clock.svg(
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text('2025-09-20, 08:00', style: theme.textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Assets.icons.star.svg(
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text('4.5', style: theme.textTheme.bodyMedium),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '(150 Reviews)',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TourHeaderSectionShimmer extends StatelessWidget {
  const TourHeaderSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerContainer(width: double.infinity, height: 24),
        SizedBox(height: AppSpacing.sm),
        ShimmerContainer(width: 150, height: 16),
        SizedBox(height: AppSpacing.sm),
        ShimmerContainer(width: 180, height: 16),
      ],
    );
  }
}
