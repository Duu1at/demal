import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract class ErrorHandler {
  const ErrorHandler();

  void handleError(
    Object error,
    BuildContext context,
  );

  String parseErrorMessage(Object error) =>
      error is AppException ? error.getUiMessage() : 'Пожалуйста, попробуйте позже или свяжитесь с поддержкой';

  ErrorModel parseErrorModel(Object error) {
    return error is AppException
        ? error.getModel()
        : const ErrorModel(
            title: 'Что-то пошло не так',
            message: 'Пожалуйста, попробуйте позже или свяжитесь с поддержкой',
          );
  }
}
