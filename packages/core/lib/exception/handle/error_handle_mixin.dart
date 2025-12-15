import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract class ErrorHandler {
  const ErrorHandler();

  void handleError(
    Object error,
    BuildContext context,
  );

  String parseErrorMessage(Object error) {
    if (error is AppException) return error.getUiMessage();
    if (error is DioException) {
      return error.errorMessage ?? 'Пожалуйста, попробуйте позже или свяжитесь с поддержкой';
    }
    return 'Пожалуйста, попробуйте позже или свяжитесь с поддержкой';
  }

  ErrorModel parseErrorModel(Object error) {
    if (error is AppException) return error.getModel();
    if (error is DioException) {
      return ErrorModel(
        title: 'Ошибка',
        message: error.errorMessage ?? 'Пожалуйста, попробуйте позже или свяжитесь с поддержкой',
      );
    }
    return const ErrorModel(
      title: 'Что-то пошло не так',
      message: 'Пожалуйста, попробуйте позже или свяжитесь с поддержкой',
    );
  }
}
