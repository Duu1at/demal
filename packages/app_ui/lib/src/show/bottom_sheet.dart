import 'package:app_ui/src/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

abstract class BottomSheets {
  static Future<T?> showModalSettingsSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    Color? backgroundColor,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    bool enableDrag = false,
    bool showDragHandle = false,
  }) {
    return showModalBottomSheet<T>(
      showDragHandle: showDragHandle,
      context: context,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.md))),
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
}
