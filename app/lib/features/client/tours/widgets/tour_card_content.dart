import 'package:app/features/client/tours/widgets/tour_card_footer.dart';
import 'package:app/features/client/tours/widgets/tour_header_row.dart';
import 'package:app/utils/tour_card/tour_card_utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TourCardContent extends StatelessWidget {
  const TourCardContent({
    required this.typeOfTour,
    required this.rating,
    required this.ratingCount,
    required this.title,
    required this.features,
    required this.duration,
    required this.distance,
    required this.city,
    required this.country,
    required this.price,
    required this.onBookTap,
    super.key,
  });

  final String? typeOfTour;
  final double? rating;
  final int? ratingCount;
  final String? title;
  final List<String>? features;
  final String? duration;
  final String? distance;
  final String? city;
  final String? country;
  final double? price;
  final VoidCallback? onBookTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(textTheme),
          const SizedBox(height: AppSpacing.xs),
          TourHeaderRow(
            typeOfTour: typeOfTour,
            rating: rating,
            ratingCount: ratingCount,
          ),
          const SizedBox(height: AppSpacing.xs),
          _buildDuration(textTheme, context),
          const SizedBox(height: AppSpacing.xs),
          _buildLocation(textTheme, context),
          const SizedBox(height: AppSpacing.sm),
          TourCardFooter(price: price, onBookTap: onBookTap),
        ],
      ),
    );
  }

  Widget _buildTitle(TextTheme textTheme) {
    return Text(
      title ?? '',
      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDuration(TextTheme textTheme, BuildContext context) {
    final durationText = TourCardUtils.formatDuration(duration, distance);
    if (durationText.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        Icon(
          Icons.calendar_month_outlined,
          size: 16,
          color: context.appColors.disabled,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          durationText,
          style: textTheme.bodySmall?.copyWith(
            color: context.appColors.disabled,
          ),
        ),
      ],
    );
  }

  Widget _buildLocation(TextTheme textTheme, BuildContext context) {
    final locationText = TourCardUtils.formatLocation(city, country);
    if (locationText.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 16,
          color: context.appColors.disabled,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          locationText,
          style: textTheme.bodySmall?.copyWith(
            color: context.appColors.disabled,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
