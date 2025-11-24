import 'dart:async';

import 'package:app/utils/image_storage/image_storage.dart';
import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarOverlay extends StatefulWidget {
  const AvatarOverlay({
    required this.animationController,
    this.avatarUrl,
    this.globalKey,
    super.key,
  });

  final String? avatarUrl;
  final GlobalKey? globalKey;
  final AnimationController animationController;

  @override
  State<AvatarOverlay> createState() => _AvatarOverlayState();
}

class _AvatarOverlayState extends State<AvatarOverlay> {
  late RectTween rectTween;
  Rect? beginRect;

  @override
  void initState() {
    unawaited(widget.animationController.forward());
    if (widget.globalKey?.currentContext != null) {
      beginRect = _getRect(widget.globalKey!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    final imageSize = mediaSize.height * 0.33;
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
    final result = widget.avatarUrl?.isNotEmpty ?? false
        ? Center(
            child: CachedNetworkImage(
              imageUrl: widget.avatarUrl!,
              fit: BoxFit.cover,
              cacheManager: ImageStorage.instance.avatarManager,
              width: imageSize,
              height: imageSize,
              imageBuilder: (context, image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(imageSize),
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Image(image: image, fit: BoxFit.cover),
                  ),
                );
              },
              errorWidget: (context, error, stackTrace) => emptyState,
              progressIndicatorBuilder: (context, child, loadingProgress) => ShimmerContainer(
                radius: imageSize,
                width: imageSize,
                height: imageSize,
              ),
            ),
          )
        : emptyState;
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        if (beginRect == null) return const SizedBox.shrink();
        
        rectTween = RectTween(
          begin: beginRect,
          end: Rect.fromCenter(
            center: Offset(mediaSize.width / 2, mediaSize.height * 0.3),
            width: imageSize,
            height: imageSize,
          ),
        );

        return Stack(
          children: [
            Positioned.fromRect(
              rect: rectTween.evaluate(
                CurvedAnimation(
                  parent: widget.animationController,
                  curve: Curves.easeInOut,
                ),
              )!,
              child: result,
            ),
          ],
        );
      },
    );
  }

  Rect _getRect(GlobalKey globalKey) {
    final renderBoxContainer = globalKey.currentContext!.findRenderObject()! as RenderBox;
    return Rect.fromPoints(
      renderBoxContainer.localToGlobal(renderBoxContainer.paintBounds.topLeft),
      renderBoxContainer.localToGlobal(
        renderBoxContainer.paintBounds.bottomRight,
      ),
    );
  }
}
