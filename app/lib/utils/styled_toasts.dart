import 'package:app/main.dart';
import 'package:flutter/material.dart';


class AppSnackBar {
  static Future<void> showBaseSnack(String text) async {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.black.withValues(alpha: .65),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  static void showSnackBar(String text, {bool isSuccess = false, int seconds = 2}) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSuccess ? const Color(0xff54B25A) : const Color(0xFFFC4637),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  // static void showErrorSnackBar(AppDioException exception) {
  //   scaffoldMessengerKey.currentState?.showSnackBar(
  //     SnackBar(
  //       duration: const Duration(seconds: 2),
  //       elevation: 0,
  //       backgroundColor: Colors.transparent,
  //       content: Container(
  //         padding: const EdgeInsets.all(16),
  //         decoration: BoxDecoration(color: const Color(0xFFFC4637), borderRadius: BorderRadius.circular(16)),
  //         child: Text(
  //           exception.message,
  //           textAlign: TextAlign.center,
  //           style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // static void showToastAbaveSheet(BuildContext context, String text, {bool isSuccess = false, Duration? duration}) {
  //   showToast(
  //     text,
  //     // backgroundColor: isSuccess ? context.colors.secondary : context.colors.error,
  //     context: context,
  //     animation: StyledToastAnimation.fade,
  //     duration: duration ?? const Duration(seconds: 5),
  //   );
  // }
}
