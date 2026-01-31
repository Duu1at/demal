import 'package:flutter/material.dart';
import 'package:core/core.dart';

@immutable
final class ConvertException extends AppException<Object> {
  const ConvertException(
    super.error, {
    super.stackTrace,
    super.message,
    super.type,
    super.handleType,
  });

  @override
  ErrorModel getModel() {
    return ErrorModel(
      title: L10nService.instance.l10n.somethingWentWrong,
      message: L10nService.instance.l10n.technicalErrorContactSupport,
    );
  }

  @override
  String getUiMessage() {
    return L10nService.instance.l10n.technicalErrorContactSupport;
  }
}
