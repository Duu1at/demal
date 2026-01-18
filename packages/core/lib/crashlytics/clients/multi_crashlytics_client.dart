import 'dart:async';
import 'package:core/crashlytics/clients/crashlytics_client.dart';
import 'package:core/crashlytics/crashlytics_service.dart';
import 'package:flutter/material.dart';

abstract interface class MultiCrashlyticsClient implements CrashlyticsClient {
  void addService(CrashlyticsService service);

  void removeService(CrashlyticsService service);
}

@immutable
final class MultiCrashlyticsClientImpl implements MultiCrashlyticsClient {
  const MultiCrashlyticsClientImpl(this.services);

  final List<CrashlyticsService> services;

  @override
  void addService(CrashlyticsService service) {
    if (services.contains(service)) return;
    services.add(service);
  }

  @override
  void removeService(CrashlyticsService service) {
    if (!services.contains(service)) return;
    services.remove(service);
  }

  @override
  void setEnabled(bool enabled) {
    for (final service in services) {
      service.setEnabled(enabled);
    }
  }

  @override
  FutureOr<void> report(
    Object error,
    StackTrace? stack, {
    Map<String, Object>? parameters,
  }) {
    for (final service in services) {
      service.report(
        error,
        stack,
      );
    }
  }
}
