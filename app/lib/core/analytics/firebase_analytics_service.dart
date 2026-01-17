import 'dart:async';
import 'package:core/analytics/events/analytics_event.dart';
import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

@immutable
final class FirebaseAnalyticsService implements AnalyticsService {
  const FirebaseAnalyticsService(this.firebaseAnalytics, this.crashlyticsClient);

  final FirebaseAnalytics firebaseAnalytics;
  final CrashlyticsClient crashlyticsClient;

  @override
  FutureOr<void> setEnabled(bool enabled) async {
    try {
      await firebaseAnalytics.setAnalyticsCollectionEnabled(enabled);
    } on Object catch (e, s) {
      crashlyticsClient.report(e, s);
    }
  }

  @override
  FutureOr<void> setUserId(String userId) async {
    try {
      await firebaseAnalytics.setUserId(id: userId);
    } on Object catch (e, s) {
      crashlyticsClient.report(e, s);
    }
  }

  @override
  FutureOr<void> registerEvent(AnalyticsEvent event) {
    try {
      firebaseAnalytics.logEvent(
        name: event.name,
        parameters: event.parameters,
      );
    } on Object catch (e, s) {
      crashlyticsClient.report(e, s);
    }
  }

  @override
  RouteObserver<ModalRoute<dynamic>> get navigationAnalyticsObserver {
    return FirebaseAnalyticsObserver(analytics: firebaseAnalytics);
  }
}
