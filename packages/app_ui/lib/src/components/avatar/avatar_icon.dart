import 'dart:ui';
import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarIcon extends StatefulWidget {
  const AvatarIcon({
    super.key,
    required this.imageUrl,
    this.size,
    this.expand = false,
    this.avatarController,
    this.errorWidget,
    this.framePadding,
  });

  final String? imageUrl;
  final double? size;
  final bool expand;
  final AvatarIconController? avatarController;
  final Widget? errorWidget;
  final EdgeInsets? framePadding;

  @override
  State<AvatarIcon> createState() => _AvatarIconState();
}

class _AvatarIconState extends State<AvatarIcon>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  GlobalKey globalKey = GlobalKey();
  late AnimationController _animationController;
  bool visible = true;
  bool isError = false;

  @override
  void initState() {
    if (widget.expand && widget.imageUrl != null) {
      widget.avatarController?.onTap = _createOverlay;
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      _animationController.addStatusListener((status) async {
        if (status == AnimationStatus.reverse) {
          await Future.delayed(const Duration(milliseconds: 300));
          removeOverlay();
          visible = true;
          setState(() {});
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  void _createOverlay() async {
    if (isError) return;
    visible = false;
    setState(() {});
    final OverlayState overlay = Overlay.of(context, rootOverlay: true);
    _overlayEntry = OverlayEntry(
      canSizeOverlay: true,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            _animationController.reverse();
          },
          child: _ImageOverlay(
            imageUrl: widget.imageUrl,
            globalKey: globalKey,
            animationController: _animationController,
          ),
        );
      },
    );
    overlay.insert(_overlayEntry!);
  }

  void removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size ?? 40;
    final Widget emptyState = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: context.appColors.disabled,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(size / 5),
          child: Assets.icons.user.svg(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface,
              BlendMode.srcIn,
            ),
            width: size * 0.9,
            height: size * 0.9,
          ),
        ),
      ),
    );

    Widget result;

    if (widget.imageUrl?.isNotEmpty == true) {
      result = CachedNetworkImage(
        key: globalKey,
        imageUrl: widget.imageUrl!,
        fit: BoxFit.cover,
        errorListener: (value) {
          isError = true;
        },
        imageBuilder: (context, image) {
          return Padding(
            padding: widget.framePadding ?? EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: SizedBox(
                height: widget.size ?? 56,
                width: widget.size ?? 56,
                child: Image(image: image, fit: BoxFit.cover),
              ),
            ),
          );
        },
        errorWidget: (context, error, stackTrace) =>
            widget.errorWidget ?? emptyState,
        progressIndicatorBuilder: (context, child, loadingProgress) =>
            ShimmerContainer(
              height: widget.size ?? 56,
              width: widget.size ?? 56,
              radius: widget.size ?? 56,
            ),
      );
    } else {
      result = widget.errorWidget ?? emptyState;
    }

    return Opacity(opacity: visible ? 1 : 0, child: result);
  }
}

class _ImageOverlay extends StatefulWidget {
  const _ImageOverlay({
    this.imageUrl,
    required this.animationController,
    this.globalKey,
  });
  final String? imageUrl;
  final GlobalKey? globalKey;
  final AnimationController animationController;

  @override
  State<_ImageOverlay> createState() => _ImageOverlayState();
}

class _ImageOverlayState extends State<_ImageOverlay> {
  late RectTween rectTween;
  Rect? beginRect;

  @override
  void initState() {
    widget.animationController.forward();
    beginRect = _getRect(widget.globalKey!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.sizeOf(context);
    final double size = mediaSize.height * 0.33;

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, _) {
        rectTween = RectTween(
          begin: beginRect,
          end: Rect.fromCenter(
            center: Offset(mediaSize.width / 2, mediaSize.height * 0.3),
            width: size,
            height: size,
          ),
        );

        final double colorLerp = lerpDouble(
          0,
          0.56,
          widget.animationController.value,
        )!;

        final Widget result = widget.imageUrl?.isNotEmpty == true
            ? CachedNetworkImage(
                imageUrl: widget.imageUrl!,
                fit: BoxFit.cover,
                imageBuilder: (context, image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(size),
                    child: SizedBox(
                      height: size,
                      width: size,
                      child: Image(image: image, fit: BoxFit.cover),
                    ),
                  );
                },
                progressIndicatorBuilder: (context, child, loadingProgress) =>
                    ShimmerContainer(height: size, width: size, radius: size),
              )
            : const SizedBox();

        return Stack(
          children: [
            Container(color: Colors.black.withValues(alpha: colorLerp)),
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
    assert(globalKey.currentContext != null);
    final RenderBox renderBoxContainer =
        globalKey.currentContext!.findRenderObject()! as RenderBox;
    return Rect.fromPoints(
      renderBoxContainer.localToGlobal(renderBoxContainer.paintBounds.topLeft),
      renderBoxContainer.localToGlobal(
        renderBoxContainer.paintBounds.bottomRight,
      ),
    );
  }
}

class AvatarIconController {
  void Function()? onTap;
}
