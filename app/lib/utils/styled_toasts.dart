import 'package:app/main.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static Future<void> showBaseSnack(String text) async {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void showSnackBar(
    String text, {
    bool isSuccess = false,
    int seconds = 5,
  }) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSuccess
                ? const Color(0xff54B25A)
                : const Color(0xFFFC4637),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
