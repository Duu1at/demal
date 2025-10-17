import 'dart:io';
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
  final Function(File? bytesImge)? onUpdate;
  final Function()? onDelete;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget>
    with SingleTickerProviderStateMixin {
  ColorScheme? colorScheme;
  final GlobalKey _globalKey = GlobalKey();
  late AnimationController _animationController;
  bool visible = true;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.reverse) {
        await Future.delayed(const Duration(milliseconds: 300));
        _removeOverlay();
      }
    });
    super.initState();
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
          child: widget.avatarUrl?.isNotEmpty == true
              ? CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.avatarUrl!,
                  fit: BoxFit.cover,
                  height: widget.size ?? 72,
                  width: widget.size ?? 72,
                  imageBuilder: (context, image) {
                    return InkResponse(
                      key: _globalKey,
                      onTap: widget.isActive
                          ? () => _onTap(createOverlay: true)
                          : null,
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
                  errorWidget: (context, error, stackTrace) =>
                      _buildEmpty(context),
                  progressIndicatorBuilder: (context, child, loadingProgress) =>
                      ShimmerContainer(
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

  void _createOverlay() async {
    final OverlayState overlay = Overlay.of(context, rootOverlay: true);

    _overlayEntry = OverlayEntry(
      canSizeOverlay: true,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            _animationController.reverse();
            GoRouter.of(context).pop();
          },
          child: AvatarOverlay(
            avatarUrl: widget.avatarUrl,
            globalKey: _globalKey,
            animationController: _animationController,
          ),
        );
      },
    );
    overlay.insert(_overlayEntry!);
  }

  void _onTap({bool createOverlay = false}) async {
    if (widget.expand && createOverlay) {
      _createOverlay();
      visible = false;
      setState(() {});
    }
    await BottomSheets.showModalSettingsSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            onPressed: () {
              GoRouter.of(context).pop();
              select(ImageSource.camera);
            },

            child: const Text('Cнимать на фото'),
          ),
          const DividerHorisontal(),
          AppButton(
            onPressed: () {
              GoRouter.of(context).pop();
              select(ImageSource.gallery);
            },
            child: const Text('Выберите фото'),
          ),
          const DividerHorisontal(),
          AppButton(
            onPressed: () {
              if (widget.onDelete != null) {
                widget.onDelete!();
              }
              GoRouter.of(context).pop();
            },
            child: const Text('Удалить  фото'),
          ),
        ],
      ),
    );
    if (widget.expand) {
      _animationController.reverse();
    }
  }

  void select(ImageSource source) {
    ImagePicker()
        .pickImage(
          source: source,
          imageQuality: 70,
          maxHeight: 700,
          maxWidth: 700,
        )
        .then((value) async {
          if (value != null) {
            final Uint8List bytes = await value.readAsBytes();
            colorScheme = await ColorScheme.fromImageProvider(
              provider: MemoryImage(bytes),
            );

            if (widget.onUpdate != null) {
              widget.onUpdate!(await File(value.path).writeAsBytes(bytes));
            }
          }
        })
        .catchError((err) {
          if (err is PlatformException) {
            if (err.code == 'photo_access_denied' ||
                err.code == 'camera_access_denied') {
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

  void accessModal(ImageSource source) async {
    await BottomSheets.showModalSettingsSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            onPressed: () {
              if (widget.onDelete != null) {
                widget.onDelete!();
              }
              GoRouter.of(context).pop();
            },
            child: const Text('Удалить  фото'),
          ),
        ],
      ),
    );
  }
}
