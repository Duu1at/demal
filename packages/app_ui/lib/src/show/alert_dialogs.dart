import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

enum AlertDialogType {
  success,
  wrarning,
  information,
  error;

  static Color _getBgColor(AlertDialogType typeAlertDialog) {
    switch (typeAlertDialog) {
      case AlertDialogType.success:
        return const Color(0xff047857);
      case AlertDialogType.wrarning:
        return const Color(0xffB45309);
      case AlertDialogType.information:
        return const Color(0xffEFF3FF);
      case AlertDialogType.error:
        return const Color(0xffB91C21);
    }
  }

  static Color _getTextColor(AlertDialogType typeAlertDialog) {
    switch (typeAlertDialog) {
      case AlertDialogType.success:
        return const Color(0xff047857);
      case AlertDialogType.wrarning:
        return const Color(0xffB45309);
      case AlertDialogType.information:
        return const Color(0xff1D4ED8);
      case AlertDialogType.error:
        return const Color(0xffB91C21);
    }
  }
}

abstract class AlertDialogs {
  static Future<T?> showAmen<T>({
    required BuildContext context,
    AlertDialogType typeAlertDialog = AlertDialogType.information,
    String title = 'Test',
    String buttonText = 'Test',
    bool barrierDismissible = true,
    String? content,
    void Function()? onPressed,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(AppSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: AlertDialogType._getBgColor(typeAlertDialog),
          contentTextStyle: textTheme.titleMedium?.copyWith(
            color: AlertDialogType._getTextColor(typeAlertDialog),
          ),
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: AlertDialogType._getTextColor(typeAlertDialog),
          ),
          actionsAlignment: MainAxisAlignment.center,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.check,
                color: AlertDialogType._getTextColor(typeAlertDialog),
              ),
              Text('test'),
            ],
          ),
          content: content != null
              ? Text(content, textAlign: TextAlign.center)
              : null,
        );
      },
    );
  }
}
