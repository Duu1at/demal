import 'package:app/app/router/app_router.dart';
import 'package:app/client_home/utils/tour_model_extensions.dart';
import 'package:app/client_home/widgets/tour_card/tour_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';

class TourCardWidget extends StatelessWidget {
  const TourCardWidget({
    required this.tour,
    this.cacheManager,
    this.onTap,
    this.onBookTap,
    super.key,
  });

  final TourModel tour;
  final CacheManager? cacheManager;
  final VoidCallback? onTap;
  final VoidCallback? onBookTap;

  @override
  Widget build(BuildContext context) {
    return TourCard(
      imageUrl: tour.mainImageUrl,
      rating: tour.averageRating,
      ratingCount: tour.reviewsCount ?? 0,
      typeOfTour: tour.tourType ?? '',
      title: tour.title ?? '',
      features: tour.whatsIncluded ?? [],
      duration: tour.formatDuration(),
      city: tour.city,
      country: tour.country,
      price: tour.price?.toDouble(),
      cacheManager: cacheManager,
      onTap:
          onTap ??
          () async {
            if (tour.tourId != null) {
              await context.pushNamed(AppRouter.clientTourDetails);
            }
          },
      onBookTap:
          onBookTap ??
          () async {
            if (tour.tourId != null) {
              await context.pushNamed(AppRouter.clientTourTickets);
            }
          },
    );
  }
}
