import 'dart:io';
import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/components/avatar/avatar_overlay.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  late final AvatarController _controller;
  bool visible = true;

  @override
  void initState() {
    super.initState();
    _controller = AvatarController(vsync: this);
    _controller.attachRemoveCallback(() {
      visible = true;
      if (mounted) setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.setRouterIfNeeded(context, widget.expand, _routerListener);
  }

  void _routerListener() {
    String? currentRoute;
    try {
      currentRoute = GoRouter.of(
        context,
      ).routerDelegate.currentConfiguration.last.matchedLocation;
    } catch (_) {
      currentRoute = GoRouter.of(
        context,
      ).routeInformationProvider.value.uri.path;
    }
  }

  @override
  void dispose() {
    _controller.dispose(_routerListener);
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

  Future<void> _onTap({bool createOverlay = false}) async {
    if (widget.expand && createOverlay) {
      final entry = OverlayEntry(
        builder: (ctx) => GestureDetector(
          onTap: () {
            _controller.animationController.reverse();
            GoRouter.of(ctx).pop();
          },
          child: AvatarOverlay(
            globalKey: _globalKey,
            avatarUrl: widget.avatarUrl,
            animationController: _controller.animationController,
            themeData: Theme.of(context),
            fallbackSize: MediaQuery.sizeOf(context).height * 0.33,
          ),
        ),
      );
      _controller.insertOverlay(context, entry);
      visible = false;
      setState(() {});
    }
    AvatarPickerService.pickFrom(context);
    if (widget.expand) {
      _controller.animationController.reverse();
    }
  }

  // void _select() {
  // ImagePicker()
  //     .pickImage(
  //       source: source,
  //       imageQuality: 70,
  //       maxHeight: 700,
  //       maxWidth: 700,
  //     )
  //     .then((value) async {
  //       if (value != null) {
  //         Uint8List? bytes = await value.readAsBytes();

  //         var res = await ImageEditorRoute(
  //           extra: EditorExtra(bytes),
  //         ).push<EditorResult>(context);
  //         if (res?.type == EditorType.finish) {
  //           bytes = res?.image;
  //           if (bytes != null) {
  //             colorScheme = await ColorScheme.fromImageProvider(
  //               provider: MemoryImage(bytes),
  //             );
  //             if (widget.onUpdate != null) {
  //               widget.onUpdate!(await File(value.path).writeAsBytes(bytes));
  //             }
  //           }
  //         } else if (res?.type == EditorType.repeate) {
  //           LoadingOverlay.removeLoadingOverlay();
  //           _select(source);
  //         } else if (res?.type == EditorType.error) {
  //           LoadingOverlay.removeLoadingOverlay();
  //           ExceptionWorker.proccessException(
  //             LocaleKeys.general_file_too_large_label.tr(),
  //             context: context,
  //           );
  //         }
  //       }
  //     })
  //     .catchError((err) {
  //       if (err is PlatformException) {
  //         if (err.code == 'photo_access_denied' ||
  //             err.code == 'camera_access_denied') {
  //           switch (source) {
  //             // case ImageSource.camera:
  //             //   PermissionReqeuster.requestCamera(
  //             //     onDenied: (status) => _accessModal(source),
  //             //   );
  //             //   break;
  //             // case ImageSource.gallery:
  //             //   PermissionReqeuster.requestGallery(
  //             //     onDenied: (status) => _accessModal(source),
  //             //   );
  //             //   break;
  //           }
  //         }
  //       }
  //     });
  // }

  void _accessModal() {
    // SwipeModal(
    //   context: context,
    //   useRootNavigator: true,
    //   routeArguments: RouteHelper.setArguments(
    //     analyticsName: 'modal-avatar-camera-permissions',
    //   ),
    //   child: InfoBody(
    //     svg: source == ImageSource.camera
    //         ? ComponentSvgs.camera
    //         : ComponentSvgs.gallery,
    //     title: source == ImageSource.camera
    //         ? CoreLocaleKeys.labels_camera_permission_title.trc()
    //         : LocaleKeys.permission_title.tr(),
    //     description: source == ImageSource.camera
    //         ? LocaleKeys.permission_camera_description.tr()
    //         : LocaleKeys.permission_gallery_description.tr(),
    //     bottom: ActionsBottom(
    //       buttons: [
    //         CustomButton(
    //           title: LocaleKeys.permission_button_label.tr(),
    //           onPressed: () =>
    //               openAppSettings().then((value) => GoRouter.of(context).pop()),
    //         ),
    //       ],
    //     ),
    //   ),
    // ).show();
  }
}
