import 'dart:convert';
import 'package:core/core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

@immutable
final class FirebaseRemoteConfigService implements RemoteConfigClient {
  const FirebaseRemoteConfigService(this.remoteConfig);

  final FirebaseRemoteConfig remoteConfig;

  @override
  Stream<void> get updatesStream => remoteConfig.onConfigUpdated;

  @override
  Future<void> setUp(int currentBuildNumber) async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );

    await remoteConfig.setDefaults(_defaultParams(currentBuildNumber));
  }

  @override
  Future<void> refresh() async {
    await remoteConfig.fetchAndActivate();
  }

  @override
  Future<RemoteConfigModel> getConfig() async {
    final appVersion = await _fetchAndDecode<AppVersionConfigModel>(
      key: RemoteConfigKeys.appVersion,
      parser: (String value) => AppVersionConfigModel.fromJson(
        jsonDecode(value) as Map<String, dynamic>,
      ),
    );
    final technicalBreak = remoteConfig.getBool(RemoteConfigKeys.technicalBreak);

    return RemoteConfigModel(
      technicalBreak: technicalBreak,
      appVersion: appVersion,
    );
  }

  Future<T> _fetchAndDecode<T>({
    required String key,
    required T Function(String value) parser,
  }) async {
    final configString = remoteConfig.getString(key);

    if (configString.isEmpty) throw Exception('Empty remote config value for key: $key');

    return parser(configString);
  }

  static Map<String, dynamic> _defaultAppVersionValue(int currentBuildNumber) {
    return {
      'android': {
        'requiredBuildNumber': currentBuildNumber,
        'recommendedBuildNumber': currentBuildNumber,
      },
      'ios': {
        'requiredBuildNumber': currentBuildNumber,
        'recommendedBuildNumber': currentBuildNumber,
      },
    };
  }

  static Map<String, dynamic> _defaultParams(int currentBuildNumber) {
    return {
      RemoteConfigKeys.technicalBreak: false,
      RemoteConfigKeys.appVersion: jsonEncode(_defaultAppVersionValue(currentBuildNumber)),
    };
  }
}
