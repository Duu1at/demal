import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AvatarIcon extends StatefulWidget {
  const AvatarIcon({
    required this.imageUrl,
    required this.cacheManager,
    this.size,
    this.expand = false,
    this.avatarController,
    this.errorWidget,
    this.framePadding,
    super.key,
  });

  final CacheManager cacheManager;
  final String? imageUrl;
  final double? size;
  final bool expand;
  final AvatarIconController? avatarController;
  final Widget? errorWidget;
  final EdgeInsets? framePadding;

  @override
  State<AvatarIcon> createState() => _AvatarIconState();
}

class _AvatarIconState extends State<AvatarIcon> with SingleTickerProviderStateMixin {
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
          await Future<void>.delayed(const Duration(milliseconds: 300));
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

  Future<void> _createOverlay() async {
    if (isError) return;
    visible = false;
    setState(() {});
    final overlay = Overlay.of(context, rootOverlay: true);
    _overlayEntry = OverlayEntry(
      canSizeOverlay: true,
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            await _animationController.reverse();
          },
          child: AvatarOverlay(
            avatarUrl: widget.imageUrl,
            globalKey: globalKey,
            animationController: _animationController,
            cacheManager: widget.cacheManager,
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
    final size = widget.size ?? 40;
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

    if (widget.imageUrl?.isNotEmpty ?? false) {
      result = CachedNetworkImage(
        key: globalKey,
        imageUrl: widget.imageUrl!,
        cacheManager: widget.cacheManager,
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
        errorWidget: (context, error, stackTrace) => widget.errorWidget ?? emptyState,
        progressIndicatorBuilder: (context, child, loadingProgress) => ShimmerContainer(
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

class AvatarIconController {
  void Function()? onTap;
}
