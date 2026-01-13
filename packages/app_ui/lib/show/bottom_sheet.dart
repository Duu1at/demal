import 'package:app_ui/colors/app_theme_color_extension.dart';
import 'package:app_ui/spacing/app_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class BottomSheets {
  static Future<T?> showModalSettingsSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    Color? backgroundColor,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
    ),
    bool enableDrag = false,
    bool showDragHandle = false,
  }) {
    return showModalBottomSheet<T>(
      showDragHandle: showDragHandle,
      context: context,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor ?? context.appColors.bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.md),
        ),
      ),
      enableDrag: enableDrag,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    List<Widget>? content,
    List<CustomActionButton>? actions,
    bool useRootNavigator = true,
    Color? backgroundColor,
  }) async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return showCupertinoModalPopup<T>(
          context: context,
          useRootNavigator: useRootNavigator,
          builder: (BuildContext context) => CupertinoActionSheet(
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ),
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.android:
        return showModalBottomSheet<T>(
          context: context,
          showDragHandle: true,
          useRootNavigator: useRootNavigator,
          backgroundColor: backgroundColor,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.sm,
                top: AppSpacing.xs,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: actions?.cast<Widget>() ?? const [],
              ),
            );
          },
        );
    }
  }
}

class CustomActionButton extends StatefulWidget {
  const CustomActionButton({
    required this.onTap,
    required this.title,
    super.key,
  });

  final String title;
  final VoidCallback onTap;

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  TextStyle? style;

  @override
  Widget build(BuildContext context) {
    Widget? result;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        result = CupertinoActionSheetAction(
          onPressed: widget.onTap,
          child: Text(widget.title, style: style),
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        result = MaterialActionSheetAction(
          title: widget.title,
          onTap: widget.onTap,
        );
    }
    return result;
  }
}

class MaterialActionSheetAction extends StatefulWidget {
  const MaterialActionSheetAction({
    required this.title,
    super.key,
    this.onTap,
  });
  final String title;
  final VoidCallback? onTap;

  @override
  State<MaterialActionSheetAction> createState() => _MaterialActionSheetActionState();
}

class _MaterialActionSheetActionState extends State<MaterialActionSheetAction> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: InkWell(
          onTap: widget.onTap,

          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(widget.title)],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
