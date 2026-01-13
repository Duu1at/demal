import 'package:app/utils/tour_card/tour_card_utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TourHeaderRow extends StatelessWidget {
  const TourHeaderRow({
    this.typeOfTour,
    this.rating,
    this.ratingCount,
    super.key,
  });

  final String? typeOfTour;
  final double? rating;
  final int? ratingCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.travel_explore_outlined,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  typeOfTour ?? '',
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        _buildRatingSection(textTheme),
      ],
    );
  }

  Widget _buildRatingSection(TextTheme textTheme) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          rating?.toStringAsFixed(1) ?? '0',
          style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          ' (${TourCardUtils.formatReviewsCount(ratingCount)})',
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
