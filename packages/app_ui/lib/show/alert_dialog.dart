import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AlertDialogType {
  success,
  wrarning,
  info,
  error;

  static Color _getBgColor(AlertDialogType typeAlertDialog) {
    switch (typeAlertDialog) {
      case AlertDialogType.success:
        return const Color(0xffECFEF8);
      case AlertDialogType.wrarning:
        return const Color(0xffFFF4EB);
      case AlertDialogType.info:
        return const Color(0xffEFF3FF);
      case AlertDialogType.error:
        return const Color(0xffFEF2F2);
    }
  }

  static Color _getTextColor(AlertDialogType typeAlertDialog) {
    switch (typeAlertDialog) {
      case AlertDialogType.success:
        return const Color(0xff047857);
      case AlertDialogType.wrarning:
        return const Color(0xffB45309);
      case AlertDialogType.info:
        return const Color(0xff1D4ED8);
      case AlertDialogType.error:
        return const Color(0xffB91C21);
    }
  }

  static SvgPicture _getIconPath(AlertDialogType typeAlertDialog) {
    switch (typeAlertDialog) {
      case AlertDialogType.success:
        return Assets.icons.tickCircle.svg();
      case AlertDialogType.wrarning:
        return Assets.icons.danger.svg();
      case AlertDialogType.info:
        return Assets.icons.infoCircle.svg();
      case AlertDialogType.error:
        return Assets.icons.closeCircle.svg();
    }
  }
}

abstract class AlertDialogs {
  static Future<T?> alertDialog<T>({
    required BuildContext context,
    AlertDialogType typeAlertDialog = AlertDialogType.info,
    String title = 'Alert Title',
    String subTitle = 'Lorem ipsum dolor sit amet consectetur.',
    String buttonText = 'Text Link',
    bool barrierDismissible = true,
    bool showCloseButton = true,
    Widget? content,
    List<Widget>? actions,
    void Function()? onPressed,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          iconPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            side: BorderSide(
              color: AlertDialogType._getTextColor(typeAlertDialog),
            ),
          ),
          backgroundColor: AlertDialogType._getBgColor(typeAlertDialog),
          contentTextStyle: textTheme.titleMedium?.copyWith(
            color: AlertDialogType._getTextColor(typeAlertDialog),
          ),
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: AlertDialogType._getTextColor(typeAlertDialog),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AlertDialogType._getIconPath(typeAlertDialog),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: textTheme.titleMedium?.copyWith(
                            color: AlertDialogType._getTextColor(
                              typeAlertDialog,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (showCloseButton)
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Assets.icons.close.svg(
                              colorFilter: ColorFilter.mode(
                                AlertDialogType._getTextColor(
                                  typeAlertDialog,
                                ),
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subTitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AlertDialogType._getTextColor(typeAlertDialog),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: content,
          actions: actions,
        );
      },
    );
  }
}
