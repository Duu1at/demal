import 'dart:async';

import 'package:core/analytics/events/analytics_event.dart';
import 'package:flutter/material.dart';

abstract interface class AnalyticsService {
  FutureOr<void> setEnabled(bool enabled);

  FutureOr<void> setUserId(String userId);

  FutureOr<void> registerEvent(AnalyticsEvent event);

  RouteObserver<ModalRoute<dynamic>> get navigationAnalyticsObserver;
}
