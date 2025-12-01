import 'dart:async';
import 'dart:io';

import 'package:app/utils/permission/permission_reqester.dart';
import 'package:app/widgets/avatar/avatar_display.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditableAvatar extends StatefulWidget {
  const EditableAvatar({
    super.key,
    this.avatarUrl,
    this.onUpdate,
    this.size = 72,
    this.onDelete,
    this.isReadOnly = false,
    this.expand = false,
  });

  final String? avatarUrl;
  final bool isReadOnly;
  final double size;
  final bool expand;
  final ValueChanged<File>? onUpdate;
  final VoidCallback? onDelete;

  @override
  State<EditableAvatar> createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> with SingleTickerProviderStateMixin {
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeEdit = widget.size / 6;

    final Widget result = Stack(
      children: [
        AvatarDisplay(
          key: _globalKey,
          avatarUrl: widget.avatarUrl,
          size: widget.size,
          onTap: !widget.isReadOnly ? () => _onTap(createOverlay: true) : null,
        ),
        if (!widget.isReadOnly)
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
            if (context.mounted) {
              GoRouter.of(context).pop();
            }
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

  Future<void> _onTap({bool createOverlay = false}) async {
    if (widget.expand && createOverlay) {
      await _createOverlay();
      visible = false;
      setState(() {});
    }
    if (!mounted) return;

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
          if (value != null) {
            widget.onUpdate?.call(File(value.path));
          }
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
    if (!mounted) return;
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
