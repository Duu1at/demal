import 'package:app/client/home/widgets/tour_card/tour_card_constants.dart';
import 'package:app/client/home/widgets/tour_card/tour_card_footer.dart';
import 'package:app/client/home/utils/tour_card_utils.dart';
import 'package:app/client/home/widgets/tour_card/tour_features_row.dart';
import 'package:app/client/home/widgets/tour_card/tour_header_row.dart';
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
      padding: const EdgeInsets.all(TourCardConstants.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TourHeaderRow(
            typeOfTour: typeOfTour,
            rating: rating,
            ratingCount: ratingCount,
          ),
          const SizedBox(height: TourCardConstants.spacingSmall),
          _buildTitle(textTheme),
          const SizedBox(height: TourCardConstants.spacingMedium),
          TourFeaturesRow(features: features ?? []),
          const SizedBox(height: TourCardConstants.spacingSmall),
          _buildDuration(textTheme),
          const SizedBox(height: 2),
          _buildLocation(textTheme),
          const SizedBox(height: TourCardConstants.spacingLarge),
          TourCardFooter(price: price, onBookTap: onBookTap),
        ],
      ),
    );
  }

  Widget _buildTitle(TextTheme textTheme) {
    return Text(
      title ?? '',
      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDuration(TextTheme textTheme) {
    final durationText = TourCardUtils.formatDuration(duration, distance);
    if (durationText.isEmpty) return const SizedBox.shrink();

    return Text(durationText, style: textTheme.bodySmall);
  }

  Widget _buildLocation(TextTheme textTheme) {
    final locationText = TourCardUtils.formatLocation(city, country);
    if (locationText.isEmpty) return const SizedBox.shrink();

    return Text(locationText, style: textTheme.bodySmall);
  }
}
