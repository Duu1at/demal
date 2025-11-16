import 'package:app/core/error_parser/error_parcer.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

@immutable
final class SnackBarErrorHandle implements ErrorHandle<SnackBarErrorHandleParam> {
  const SnackBarErrorHandle._();

  static const SnackBarErrorHandle I = SnackBarErrorHandle._();

  @override
  void handleError(SnackBarErrorHandleParam param) {
    final message = Parser.getMessage(param.error);

    switch (param.type) {
      case SnackBarType.error:
        AppSnackbar.showError(context: param.context, title: message);
      case SnackBarType.success:
        AppSnackbar.showSuccess(context: param.context, title: message);
      case SnackBarType.info:
        AppSnackbar.showInfo(context: param.context, title: message);
    }
  }
}
