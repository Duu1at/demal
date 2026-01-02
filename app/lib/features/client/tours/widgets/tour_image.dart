import 'package:app/features/client/tours/widgets/tour_card_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';

class TourImage extends StatelessWidget {
  const TourImage({this.imageUrl, this.cacheManager, super.key});

  final String? imageUrl;
  final CacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: TourCardConstants.imageAspectRatio,
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        cacheManager: cacheManager,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(color: Colors.grey[300]),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: TourCardConstants.errorIconSize,
        color: Colors.grey,
      ),
    );
  }
}
