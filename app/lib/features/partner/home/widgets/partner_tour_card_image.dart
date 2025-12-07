import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  static const double _imageHeight = 200;

  @override
  Widget build(BuildContext context) {
    final imageUrl = tour.mainImageUrl;
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: _imageHeight,
      child: imageUrl != null && imageUrl.isNotEmpty
          ? _NetworkImage(
              imageUrl: imageUrl,
              cacheManager: cacheManager,
              theme: theme,
            )
          : _PlaceholderImage(theme: theme),
    );
  }
}

class _NetworkImage extends StatelessWidget {
  const _NetworkImage({
    required this.imageUrl,
    required this.cacheManager,
    required this.theme,
  });

  final String imageUrl;
  final CacheManager? cacheManager;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: cacheManager,
      width: double.infinity,
      height: PartnerTourCardImage._imageHeight,
      fit: BoxFit.cover,
      memCacheWidth: 800,
      memCacheHeight: (PartnerTourCardImage._imageHeight * 2).round(),
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
      alignment: Alignment.center,
      fadeInCurve: Curves.easeIn,
      placeholder: (_, _) => const _LoadingPlaceholder(),
      errorWidget: (_, _, _) => _PlaceholderImage(theme: theme),
      filterQuality: FilterQuality.medium,
      httpHeaders: const {'Accept': 'image/*'},
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  const _LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ShimmerContainer(
      height: PartnerTourCardImage._imageHeight,
      width: double.infinity,
      radius: 0,
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
          Icons.image_outlined,
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
          size: 32,
        ),
      ),
    );
  }
}
