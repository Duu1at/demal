import 'package:app/features/client/home/widgets/tour_card/tour_card_constants.dart';
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
                color: context.appColors.disabled,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  typeOfTour ?? '',
                  style: textTheme.bodySmall?.copyWith(
                    color: context.appColors.disabled,
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
          size: TourCardConstants.ratingIconSize,
        ),
        const SizedBox(width: TourCardConstants.spacingSmall),
        Text(
          rating?.toStringAsFixed(1) ?? '0.0',
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
