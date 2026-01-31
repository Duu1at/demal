import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseErrorHandler extends ErrorHandler {
  const BaseErrorHandler();

  @override
  void handleError(Object error, BuildContext context) {
    final handleType = getHandleType(error);
    return switch (handleType) {
      ExceptionHandleType.dialog => context.read<ErrorHandleDialog>().handleError(error, context),
      ExceptionHandleType.snackbar => context.read<ErrorHandleSnackBar>().handleError(error, context),
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
    BuildContext context, {
    VoidCallback? onThen,
    String? description,
  }) {
    if (!context.mounted) return;
    final model = parseErrorModel(error);
    showAdaptiveDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (model.icon != null)
                Padding(
                  padding: const EdgeInsetsGeometry.all(8),
                  child: model.icon,
                ),
              Text(model.title),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(model.message),
              const SizedBox(height: 8),
              if (description != null) Text(description),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.ok),
            ),
          ],
        );
      },
    ).then((_) => onThen?.call());
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
    AppSnackbar.showError(context: context, title: parseErrorMessage(error));
  }
}
