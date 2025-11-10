import 'dart:async';
import 'dart:io';
import 'package:app/utils/image_storage/image_storage.dart';
import 'package:app/utils/permission/permission_reqester.dart';
import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

enum EditorType { repeate, finish, error }

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    super.key,
    this.avatarUrl,
    this.onUpdate,
    this.size,
    this.onDelete,
    this.isActive = false,
    this.expand = false,
  });

  final String? avatarUrl;
  final bool isActive;
  final double? size;
  final bool expand;
  final ValueChanged<File>? onUpdate;
  final VoidCallback? onDelete;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> with SingleTickerProviderStateMixin {
  ColorScheme? colorScheme;
  final GlobalKey _globalKey = GlobalKey();
  late AnimationController _animationController;
  bool visible = true;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.reverse) {
        await Future<void>.delayed(const Duration(milliseconds: 300));
        _removeOverlay();
      }
    });
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
      _overlayEntry = null;
      visible = true;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  Widget _buildEmpty(BuildContext context) {
    return InkResponse(
      onTap: widget.isActive ? _onTap : null,
      radius: 32,
      splashColor: Theme.of(context).colorScheme.primary,
      child: Assets.icons.user.svg(
        width: widget.size,
        height: widget.size,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeEdit = (widget.size ?? 72) / 6;
    final Widget result = Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.appColors.bgCard,
          ),
          child: widget.avatarUrl?.isNotEmpty ?? false
              ? CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.avatarUrl!,
                  fit: BoxFit.cover,
                  height: widget.size ?? 72,
                  width: widget.size ?? 72,
                  imageBuilder: (context, image) {
                    return InkResponse(
                      key: _globalKey,
                      onTap: widget.isActive ? () => _onTap(createOverlay: true) : null,
                      radius: (widget.size ?? 72) / 2,
                      splashColor: colorScheme?.primaryContainer,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          (widget.size ?? 72) / 2,
                        ),
                        child: SizedBox(
                          height: widget.size ?? 72,
                          width: widget.size ?? 72,
                          child: Image(image: image, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, error, stackTrace) => _buildEmpty(context),
                  progressIndicatorBuilder: (context, child, loadingProgress) => ShimmerContainer(
                    height: widget.size ?? 72,
                    width: widget.size ?? 72,
                    radius: widget.size ?? 72,
                  ),
                )
              : _buildEmpty(context),
        ),
        if (widget.isActive)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: widget.avatarUrl != null
                  ? Assets.icons.edit.svg(
                      width: sizeEdit,
                      height: sizeEdit,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    )
                  : Assets.icons.plus.svg(
                      width: sizeEdit,
                      height: sizeEdit,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
          ),
      ],
    );
    return Opacity(opacity: visible ? 1 : 0, child: result);
  }

  Future<void> _createOverlay() async {
    final overlay = Overlay.of(context, rootOverlay: true);

    _overlayEntry = OverlayEntry(
      canSizeOverlay: true,
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            await _animationController.reverse();
            GoRouter.of(context).pop();
          },
          child: _ImageOverlay(
            avatarUrl: widget.avatarUrl,
            globalKey: _globalKey,
            animationController: _animationController,
          ),
        );
      },
    );
    overlay.insert(_overlayEntry!);
  }

  Future<void> _onTap({bool createOverlay = false}) async {
    if (widget.expand && createOverlay) {
      await _createOverlay();
      visible = false;
      setState(() {});
    }
    await BottomSheets.show<void>(
      context,
      actions: [
        CustomActionButton(
          onTap: () async {
            GoRouter.of(context).pop();
            await select(ImageSource.camera);
          },
          title: 'Камера',
        ),
        CustomActionButton(
          onTap: () async {
            GoRouter.of(context).pop();
            await select(ImageSource.gallery);
          },
          title: 'Gallery',
        ),
        CustomActionButton(
          onTap: () async {
            widget.onDelete?.call();
            GoRouter.of(context).pop();
          },
          title: 'Удалить',
        ),
      ],
    );
    if (widget.expand) {
      await _animationController.reverse();
    }
  }

  Future<void> select(ImageSource source) async {
    await ImagePicker()
        .pickImage(
          source: source,
          imageQuality: 70,
          maxHeight: 700,
          maxWidth: 700,
        )
        .then((value) async {
          // if (value != null) {
          //   Uint8List? bytes = await value.readAsBytes();

          //   final editedImage = await Navigator.push<Uint8List>(

          //   );
          //   if (editedImage == EditorType.finish) {
          //     bytes = editedImage;
          //     if (bytes != null) {
          //       colorScheme = await ColorScheme.fromImageProvider(
          //         provider: MemoryImage(bytes),
          //       );
          //       widget.onUpdate?.call(
          //         await File(value.path).writeAsBytes(bytes),
          //       );
          //     }
          //   } else if (editedImage?.type == EditorType.repeate) {
          //     context.loaderOverlay.hide();

          //     select(source);
          //   } else if (editedImage?.type == EditorType.error) {
          //     context.loaderOverlay.hide();
          //   }
          // }
        })
        .catchError((Object error) {
          if (error is PlatformException) {
            if ((error.code.toLowerCase().contains('photo_access_denied')) ||
                (error.code.toLowerCase().contains('camera_access_denied'))) {
              switch (source) {
                case ImageSource.camera:
                  PermissionReqeuster.requestCamera(
                    onDenied: (status) => accessModal(source),
                  );
                case ImageSource.gallery:
                  PermissionReqeuster.requestGallery(
                    onDenied: (status) => accessModal(source),
                  );
              }
            }
          }
        });
  }

  Future<void> accessModal(ImageSource source) async {
    await BottomSheets.showModalSettingsSheet<void>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            onPressed: () {
              widget.onDelete?.call();
              GoRouter.of(context).pop();
            },
            child: const Text('Удалить  фото'),
          ),
        ],
      ),
    );
  }
}

class _ImageOverlay extends StatefulWidget {
  const _ImageOverlay({
    required this.animationController,
    this.avatarUrl,
    this.globalKey,
  });

  final String? avatarUrl;
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
    unawaited(widget.animationController.forward());
    beginRect = _getRect(widget.globalKey!);
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
