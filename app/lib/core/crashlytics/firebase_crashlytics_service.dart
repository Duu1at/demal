import 'dart:async';
import 'dart:developer';
import 'package:core/core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

@immutable
final class FirebaseCrashlyticsService implements CrashlyticsService {
  const FirebaseCrashlyticsService(this._firebaseCrashlytics);

  final FirebaseCrashlytics _firebaseCrashlytics;

  @override
  FutureOr<void> setEnabled(bool enabled) {
    try {
      _firebaseCrashlytics.setCrashlyticsCollectionEnabled(enabled);
    } on Exception catch (e, s) {
      log('FirebaseCrashlyticsService: $e', error: e, stackTrace: s);
    }
  }

  @override
  FutureOr<void> report(Object error, StackTrace? stack) async {
    if (kDebugMode) return;
    try {
      await _firebaseCrashlytics.recordError(
        error,
        stack,
        fatal: true,
      );
    } on Exception catch (e, s) {
      log('FirebaseCrashlyticsService: $e', error: e, stackTrace: s);
    }
  }
}
