import 'package:app/app/app.dart';
import 'package:app/app/router/navigation_helper.dart';
import 'package:app/utils/tour_card/tour_model_extensions.dart';
import 'package:app/features/client/tours/widgets/tour_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';

class TourCardWidget extends StatelessWidget {
  const TourCardWidget({
    required this.tour,
    this.cacheManager,
    super.key,
  });

  final TourModel tour;
  final CacheManager? cacheManager;

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
      onTap: () => context.pushNamed(
            AppRouteNames.clientTourDetails,
            pathParameters: {'tourId': tour.tourId ?? ''},
          ),
      onBookTap: () => context.goNamedIfAuthenticated(AppRouteNames.clientBookingDetails),
    );
  }
}
