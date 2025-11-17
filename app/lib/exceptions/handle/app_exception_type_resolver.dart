import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseErrorHandler extends ErrorHandler {
  const BaseErrorHandler();

  @override
  void handleError(Object error, BuildContext context) {
    final handleType = getHandleType(error);
    return switch (handleType) {
      ExceptionHandleType.dialog => context.read<ErrorHandler>().handleError(error, context),
      ExceptionHandleType.snackbar => context.read<ErrorHandler>().handleError(error, context),
    };
  }

  ExceptionHandleType getHandleType(Object error) {
    return error is AppException ? error.handleType : ExceptionHandleType.snackbar;
  }
}

class ErrorHandleDialog extends ErrorHandler {
  const ErrorHandleDialog();

  @override
  void handleError(
    Object error,
    BuildContext context,
  ) {
    if (!context.mounted) return;
    final model = parseErrorModel(error);
    showAdaptiveDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Column(
            children: [
              if (model.icon != null)
                Padding(
                  padding: const EdgeInsetsGeometry.all(8),
                  child: model.icon,
                ),
              Text(model.title),
            ],
          ),
          content: Text(model.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class ErrorHandleSnackBar extends ErrorHandler {
  const ErrorHandleSnackBar();

  @override
  void handleError(
    Object error,
    BuildContext context,
  ) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFC4637),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              parseErrorMessage(error),
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
