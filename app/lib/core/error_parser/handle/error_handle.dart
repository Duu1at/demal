import 'package:flutter/material.dart';

abstract interface class ErrorHandle<T extends ErrorHandleParam> {
  void handleError(T param);
}

@immutable
sealed class ErrorHandleParam {
  const ErrorHandleParam(this.error, {required this.context});
  final Object error;
  final BuildContext context;
}

@immutable
final class DialogErrorHandleParam extends ErrorHandleParam {
  const DialogErrorHandleParam(
    super.error, {
    required super.context,
  });
}

@immutable
final class SnackBarErrorHandleParam extends ErrorHandleParam {
  const SnackBarErrorHandleParam(
    super.error, {
    required super.context,
    this.type = SnackBarType.info,
  });
  final SnackBarType type;
}

enum SnackBarType {
  error,
  success,
  info,
}
