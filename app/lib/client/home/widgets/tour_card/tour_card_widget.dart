import 'package:app/app/router/app_router.dart';
import 'package:app/client/home/utils/tour_model_extensions.dart';
import 'package:app/client/home/widgets/tour_card/tour_card.dart';
import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';

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
      distance: null,
      city: tour.city,
      country: tour.country,
      oldPrice: null,
      price: tour.price?.toDouble(),
      cacheManager: cacheManager,
      onTap:
          onTap ??
          () {
            if (tour.tourId != null) {
              // TODO: Реализовать передачу tourId в ClientTourDetailsView
              context.pushNamed(AppRouter.clientTourDetails);
            }
          },
      onBookTap:
          onBookTap ??
          () {
            if (tour.tourId != null) {
              context.pushNamed(AppRouter.clientTourTickets);
            }
          },
    );
  }
}
