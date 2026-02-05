import 'dart:async';
import 'package:core/core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService implements RemoteConfigService {
  const FirebaseRemoteConfigService(this._remoteConfig, this._crashlyticsClient);

  final FirebaseRemoteConfig _remoteConfig;
  final CrashlyticsClient _crashlyticsClient;

  @override
  FutureOr<void> fetchAndActivate() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );
      await _remoteConfig.fetchAndActivate();
    } on Exception catch (e, s) {
      _crashlyticsClient.report(e, s);
    }
  }

  @override
  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  @override
  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  @override
  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  @override
  String getString(String key) {
    return _remoteConfig.getString(key);
  }
}
