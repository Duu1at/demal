import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class BookingHeaderCard extends StatelessWidget {
  const BookingHeaderCard({
    super.key,
    required this.imageUrl,
    this.region,
    this.tourTitle,
    this.data,
    this.raiting,
  });

  final String imageUrl;
  final String? region;
  final String? tourTitle;
  final String? data;
  final String? raiting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tourTitle ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(raiting ?? '', style: theme.textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    region ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                data ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: context.appColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
