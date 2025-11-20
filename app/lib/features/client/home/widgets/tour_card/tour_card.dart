import 'package:app/features/client/home/widgets/tour_card/tour_card_constants.dart';
import 'package:app/features/client/home/widgets/tour_card/tour_card_content.dart';
import 'package:app/features/client/home/widgets/tour_card/tour_image.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class TourCard extends StatelessWidget {
  const TourCard({
    super.key,
    this.imageUrl,
    this.rating,
    this.ratingCount,
    this.typeOfTour,
    this.title,
    this.features,
    this.duration,
    this.distance,
    this.city,
    this.country,
    this.oldPrice,
    this.price,
    this.onTap,
    this.cacheManager,
    this.onBookTap,
  });

  final String? imageUrl;
  final double? rating;
  final int? ratingCount;
  final String? typeOfTour;
  final String? title;
  final List<String>? features;
  final String? duration;
  final String? distance;
  final String? city;
  final String? country;
  final double? oldPrice;
  final double? price;
  final VoidCallback? onTap;
  final CacheManager? cacheManager;
  final VoidCallback? onBookTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _buildDecoration(context),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TourImage(imageUrl: imageUrl, cacheManager: cacheManager),
            TourCardContent(
              typeOfTour: typeOfTour,
              rating: rating,
              ratingCount: ratingCount,
              title: title,
              features: features,
              duration: duration,
              distance: distance,
              city: city,
              country: country,
              price: price,
              onBookTap: onBookTap,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.appColors.bgCard,
      borderRadius: BorderRadius.circular(TourCardConstants.borderRadius),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.primary.withValues(
            alpha: TourCardConstants.shadowOpacity,
          ),
          blurRadius: TourCardConstants.shadowBlurRadius,
        ),
      ],
    );
  }
}
