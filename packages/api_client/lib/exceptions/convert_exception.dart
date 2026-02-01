import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:lottie/lottie.dart';

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
      icon: Lottie.asset(
        Assets.lottie.error404,
        width: 200,
        height: 200,
      ),
    );
  }

  @override
  String getUiMessage() {
    return L10nService.instance.l10n.technicalErrorContactSupport;
  }
}
