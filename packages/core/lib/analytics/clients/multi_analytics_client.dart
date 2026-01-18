import 'dart:async';
import 'package:core/analytics/clients/analytics_client.dart';
import 'package:core/analytics/events/analytics_event.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract interface class MultiAnalyticsClient implements AnalyticsClient {
  void addService(AnalyticsService service);

  void removeService(AnalyticsService service);
}

@immutable
final class MultiAnalyticsClientImpl implements MultiAnalyticsClient {
  const MultiAnalyticsClientImpl(this.services);

  final List<AnalyticsService> services;

  @override
  FutureOr<void> setEnabled(bool enabled) {
    for (final service in services) {
      service.setEnabled(enabled);
    }
  }

  @override
  List<RouteObserver<ModalRoute<dynamic>>> get navigationAnalyticsObservers {
    final list = <RouteObserver<ModalRoute<dynamic>>>[];
    for (final service in services) {
      list.add(service.navigationAnalyticsObserver);
    }

    return list;
  }

  @override
  void addService(AnalyticsService service) {
    if (!services.contains(service)) {
      services.add(service);
    }
  }

  @override
  void removeService(AnalyticsService service) {
    if (services.contains(service)) {
      services.remove(service);
    }
  }

  @override
  FutureOr<void> openApp() async {
    return _sendEvent(
      const AnalyticsEvent(name: 'open_app'),
    );
  }

  @override
  FutureOr<void> login(Map<String, Object> parameters) {
    return _sendEvent(
      AnalyticsEvent(
        name: 'login',
        parameters: parameters,
      ),
    );
  }

  @override
  FutureOr<void> logout(Map<String, Object> parameters) {
    return _sendEvent(
      AnalyticsEvent(
        name: 'logout',
        parameters: parameters,
      ),
    );
  }

  @override
  FutureOr<void> tap(Map<String, Object> parameters) {
    return _sendEvent(
      AnalyticsEvent(
        name: 'tap',
        parameters: parameters,
      ),
    );
  }

  @override
  FutureOr<void> select(Map<String, Object> parameters) {
    return _sendEvent(
      AnalyticsEvent(
        name: 'select',
        parameters: parameters,
      ),
    );
  }

  FutureOr<void> _sendEvent(AnalyticsEvent event) async {
    for (final service in services) {
      await service.registerEvent(event);
    }
  }
}
