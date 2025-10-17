import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AvatarOverlay extends StatefulWidget {
  const AvatarOverlay({
    super.key,
    required this.globalKey,
    required this.avatarUrl,
    required this.animationController,
    this.cacheManager,
    this.themeData,
    this.fallbackSize,
  });
  final GlobalKey globalKey;
  final String? avatarUrl;
  final AnimationController animationController;
  final CacheManager? cacheManager;
  final ThemeData? themeData;
  final double? fallbackSize;

  @override
  State<AvatarOverlay> createState() => _AvatarOverlayState();
}

class _AvatarOverlayState extends State<AvatarOverlay> {
  Rect? beginRect;
  late RectTween rectTween;

  @override
  void initState() {
    super.initState();
    beginRect = _getRect(widget.globalKey);
    widget.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final imageSize = widget.fallbackSize ?? (media.height * 0.33);
    final emptyState = Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        color: context.appColors.disabled,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Assets.icons.user.svg(
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
          width: imageSize,
          height: imageSize,
        ),
      ),
    );

    final result = widget.avatarUrl != null && widget.avatarUrl!.isNotEmpty
        ? Center(
            child: CachedNetworkImage(
              imageUrl: widget.avatarUrl!,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
              imageBuilder: (c, provider) => ClipRRect(
                borderRadius: BorderRadius.circular(imageSize),
                child: SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: Image(image: provider, fit: BoxFit.cover),
                ),
              ),
              errorWidget: (_, __, ___) => emptyState,
              progressIndicatorBuilder: (_, __, ___) => ShimmerContainer(
                radius: imageSize,
                width: imageSize,
                height: imageSize,
              ),
            ),
          )
        : emptyState;

    final endRect = Rect.fromCenter(
      center: Offset(media.width / 2, media.height * 0.3),
      width: imageSize,
      height: imageSize,
    );

    rectTween = RectTween(begin: beginRect, end: endRect);

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (ctx, child) {
        final rect = rectTween.evaluate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Curves.easeInOut,
          ),
        )!;
        return Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.black54)),
            Positioned.fromRect(rect: rect, child: result),
          ],
        );
      },
    );
  }

  Rect _getRect(GlobalKey key) {
    assert(key.currentContext != null);
    final RenderBox box = key.currentContext!.findRenderObject()! as RenderBox;
    final topLeftGlobal = box.localToGlobal(box.paintBounds.topLeft);
    final bottomRightGlobal = box.localToGlobal(box.paintBounds.bottomRight);
    return Rect.fromPoints(topLeftGlobal, bottomRightGlobal);
  }
}
