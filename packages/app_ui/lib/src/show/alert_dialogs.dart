import 'package:flutter/material.dart';

abstract class AlertDialogs {
  static Future<T?> showAmen<T>({
    required BuildContext context,
    required Color backgroundColor,
    required Color foregroundColor,
    String title = 'Amen',
    String buttonText = 'Amen',
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
          backgroundColor: backgroundColor,
          contentTextStyle: textTheme.titleMedium?.copyWith(
            color: foregroundColor,
          ),
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: foregroundColor,
          ),
          actionsAlignment: MainAxisAlignment.center,

          title: Text(title),
          content: content != null
              ? Text(content, textAlign: TextAlign.center)
              : null,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.maxFinite, 52),
              ),
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
