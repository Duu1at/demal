import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

abstract class AppException<T extends Object> implements Exception {
  const AppException(
    this.error, {
    this.type = ExceptionType.error,
    this.handleType = ExceptionHandleType.snackbar,
    this.stackTrace,
    this.message,
  });

  final T error;
  final ExceptionType type;
  final ExceptionHandleType handleType;
  final StackTrace? stackTrace;
  final String? message;

  String getUiMessage(BuildContext context);
  ErrorModel getModel(BuildContext context);
}

enum ExceptionType {
  error,
  warning,
  info,
}

enum ExceptionHandleType {
  dialog,
  snackbar,
}
