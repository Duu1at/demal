import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

abstract class ErrorHandler {
  const ErrorHandler();

  void handleError(
    Object error,
    BuildContext context,
  );

  String parseErrorMessage(Object error, BuildContext context) {
    if (error is AppException) return error.getUiMessage(context);
    if (error is DioException) return error.errorMessage ?? context.l10n.pleaseTryLater;
    if (error is ConnectionException) return context.l10n.noInternetConnection;
    return context.l10n.pleaseTryLater;
  }

  ErrorModel parseErrorModel(Object error, BuildContext context) {
    if (error is AppException) return error.getModel(context);
    if (error is ConnectionException) {
      return ErrorModel(
        title: context.l10n.noInternetConnection,
        message: context.l10n.checkInternetAndTryAgain,
      );
    }
    if (error is DioException) {
      return ErrorModel(
        title: context.l10n.error,
        message: error.errorMessage ?? context.l10n.pleaseTryLater,
      );
    }

    return ErrorModel(
      title: context.l10n.somethingWentWrong,
      message: context.l10n.pleaseTryLater,
    );
  }
}
