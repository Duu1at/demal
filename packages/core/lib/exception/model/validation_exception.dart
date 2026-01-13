import 'package:core/core.dart';
import 'package:flutter/widgets.dart';


final class ValidationException extends AppException<String> {
  const ValidationException(super.error);

  @override
  ErrorModel getModel(BuildContext context) {
    return ErrorModel(
      title: context.l10n.validationError,
      message: error,
    );
  }

  @override
  String getUiMessage(BuildContext context) => error;
}
