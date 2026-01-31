import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
final class ConnectionException extends AppException<Object> {
  const ConnectionException(
    super.error, {
    super.handleType = ExceptionHandleType.dialog,
    super.stackTrace,
    super.message,
    super.type,
  });

  @override
  ErrorModel getModel() {
    return ErrorModel(
      title: L10nService.instance.l10n.catchConnectionError,
      message: L10nService.instance.l10n.noInternetConnection,
    );
  }

  @override
  String getUiMessage() {
    return L10nService.instance.l10n.noInternetConnection;
  }
}
