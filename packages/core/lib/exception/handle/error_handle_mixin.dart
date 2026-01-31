import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

abstract class ErrorHandler {
  const ErrorHandler();

  void handleError(
    Object error,
    BuildContext context,
  );

  String parseErrorMessage(Object error) {
    final l10n = L10nService.instance.l10n;
    return error is String
        ? error
        : error is AppException
        ? error.getUiMessage()
        : l10n.technicalErrorContactSupport;
  }

  ErrorModel parseErrorModel(Object error) {
    final l10n = L10nService.instance.l10n;
    return error is String
        ? ErrorModel(
            title: l10n.errorOccurred,
            message: error,
          )
        : error is AppException
        ? error.getModel()
        : ErrorModel(
            title: l10n.somethingWentWrong,
            message: l10n.technicalErrorContactSupport,
          );
  }
}
