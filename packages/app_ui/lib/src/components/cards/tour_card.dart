import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TourImage(imageUrl: imageUrl, cacheManager: cacheManager),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TourHeaderRow(
                    typeOfTour: typeOfTour ?? '',
                    rating: rating ?? 0,
                    ratingCount: ratingCount ?? 0,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title ?? '',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TourFeaturesRow(features: features ?? []),
                  const SizedBox(height: 4),
                  Text(
                    '${duration ?? ''} • ${distance ?? ''}',
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 2),
                  Text('$city, $country', style: textTheme.bodySmall),
                  const SizedBox(height: 8),
                  Text(
                    'From \$${price?.toStringAsFixed(2) ?? '0.00'} per person',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourImage extends StatelessWidget {
  final String? imageUrl;
  final CacheManager? cacheManager;

  const TourImage({super.key, this.imageUrl, this.cacheManager});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        cacheManager: cacheManager,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(color: Colors.grey[300]),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_not_supported_outlined,
            size: 48,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class TourHeaderRow extends StatelessWidget {
  const TourHeaderRow({
    super.key,
    this.typeOfTour,
    this.rating,
    this.ratingCount,
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
        Text(typeOfTour ?? '', style: textTheme.bodySmall),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              rating?.toStringAsFixed(1) ?? '0.0',
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(' (${ratingCount ?? 0} Reviews)', style: textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

class TourFeaturesRow extends StatelessWidget {
  final List<String> features;

  const TourFeaturesRow({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 6,
      runSpacing: 2,
      children: features
          .map(
            (f) => Text(
              f,
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
            ),
          )
          .toList(),
    );
  }
}
