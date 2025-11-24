import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tour_repository/tour_repository.dart';

class PartnerTourCardImage extends StatelessWidget {
  const PartnerTourCardImage({
    required this.tour,
    this.cacheManager,
    super.key,
  });

  final TourModel tour;
  final CacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final imageUrl = tour.mainImageUrl;
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: SizedBox(
        width: 100,
        height: 120,
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                cacheWidth: 400,
                cacheHeight: 480,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _PlaceholderImage(theme: theme),
              )
            : _PlaceholderImage(theme: theme),
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
