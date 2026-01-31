import 'package:app/core/core.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorHandlerFactory {
  const ErrorHandlerFactory();

  ErrorHandler getHandler(
    BuildContext context,
    ExceptionHandleType handleType,
  ) {
    return switch (handleType) {
      ExceptionHandleType.dialog => context.read<ErrorHandleDialog>(),
      ExceptionHandleType.snackbar => context.read<ErrorHandleSnackBar>(),
    };
  }

  void handleError(
    BuildContext context,
    Object error,
  ) {
    final handleType = _getHandleType(error);
    getHandler(context, handleType).handleError(error, context);
  }

  ExceptionHandleType _getHandleType(Object error) {
    return error is AppException ? error.handleType : ExceptionHandleType.snackbar;
  }
}
