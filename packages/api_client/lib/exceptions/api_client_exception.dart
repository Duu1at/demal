import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

@immutable
final class ApiClientException extends AppException<DioException> {
  const ApiClientException(
    super.error, {
    super.message,
    super.stackTrace,
    super.type,
    super.handleType,
  });

  @override
  ErrorModel getModel() {
    return ErrorModel(
      title: L10nService.instance.l10n.somethingWentWrong,
      message: error.errorMessage ?? L10nService.instance.l10n.technicalErrorContactSupport,
    );
  }

  @override
  String getUiMessage() {
    return error.errorMessage ?? L10nService.instance.l10n.somethingWentWrong;
  }
}

@immutable
final class ApiClientUnknownException extends AppException<Object> {
  const ApiClientUnknownException(
    super.error, {
    super.stackTrace,
    super.message,
  });

  @override
  ErrorModel getModel() {
    return ErrorModel(
      title: L10nService.instance.l10n.somethingWentWrong,
      message: message ?? L10nService.instance.l10n.technicalErrorContactSupport,
    );
  }

  @override
  String getUiMessage() {
    return message ?? L10nService.instance.l10n.somethingWentWrong;
  }
}
