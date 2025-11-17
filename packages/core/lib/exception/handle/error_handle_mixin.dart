import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract class ErrorHandler {
  const ErrorHandler();

  void handleError(
    Object error,
    BuildContext context,
  );

  String parseErrorMessage(Object error) =>
      error is AppException ? error.getUiMessage() : 'Something went wrong';

  ErrorModel parseErrorModel(Object error) {
    return error is AppException
        ? error.getModel()
        : const ErrorModel(
            title: 'Something went wrong',
            message: 'Technical error contact support',
          );
  }
}
