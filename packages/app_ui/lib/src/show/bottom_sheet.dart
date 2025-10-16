import 'package:app_ui/src/colors/app_theme_color_extension.dart';
import 'package:app_ui/src/spacing/app_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class BottomSheets {
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
      backgroundColor: backgroundColor ?? context.appColors.alertBackground,
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
    Widget? header,
    String? title,
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
            title: header != null || title != null
                ? Column(
                    children: [
                      if (header != null) header,
                      if (title != null)
                        Text(
                          title,
                          style: AppFonts.font.mSemibold.copyWith(
                            color: Theme.of(
                              context,
                            ).extension<CustomMainThemeData>()?.secondary,
                          ),
                        ),
                    ],
                  )
                : null,
            message: content != null ? Column(children: content) : null,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: Text(
                CoreLocaleKeys.buttons_cancel_title.trc(),
                style: AppFonts.font.mSemibold.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<CustomButtonThemeData>()?.primary?.defaultBckgr,
                ),
              ),
            ),
          ),
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return showModalBottomSheet<T>(
          context: context,
          showDragHandle: true,
          useRootNavigator: useRootNavigator,
          backgroundColor: backgroundColor,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.s8x,
                top: AppSpacing.s2x,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (header != null) header,
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.s4x,
                        bottom: AppSpacing.s2x,
                      ),
                      child: CustomTitle.h3(title),
                    ),
                  ...actions as List<Widget>,
                ],
              ),
            );
          },
        );
    }
  }
}
