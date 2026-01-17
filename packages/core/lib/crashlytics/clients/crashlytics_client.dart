import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract interface class CrashlyticsClient {
  FutureOr<void> setEnabled(bool enabled);

  FutureOr<void> report(
    Object error,
    StackTrace? stack,
  );
}

@immutable
final class CrashlyticsClientImpl implements CrashlyticsClient {
  const CrashlyticsClientImpl(this.service);

  final CrashlyticsService service;

  @override
  FutureOr<void> setEnabled(bool enabled) {
    return service.setEnabled(enabled);
  }

  @override
  FutureOr<void> report(
    Object error,
    StackTrace? stack, {
    Map<String, Object>? parameters,
  }) {
    return service.report(
      error,
      stack,
    );
  }
}
