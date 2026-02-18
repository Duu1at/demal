import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

enum UpdateType {
  none,
  soft,
  force,
}

final class VersionCheckService {
  const VersionCheckService(this._remoteConfig);

  final RemoteConfigService _remoteConfig;

  static const String _keyLatestVersion = 'latest_version';
  static const String _keyMinRequiredVersion = 'minimum_required_version';
  static const String _keyForceUpdate = 'force_update';

  Future<UpdateType> checkVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = _parseVersion(packageInfo.version);

      final latestVersionStr = _remoteConfig.getString(_keyLatestVersion);
      final minRequiredVersionStr = _remoteConfig.getString(_keyMinRequiredVersion);
      final forceUpdateRemote = _remoteConfig.getBool(_keyForceUpdate);

      debugPrint('VersionCheck: Local Version: ${packageInfo.version}');
      debugPrint('VersionCheck: Remote Latest: $latestVersionStr');
      debugPrint('VersionCheck: Remote Min: $minRequiredVersionStr');
      debugPrint('VersionCheck: Remote Force: $forceUpdateRemote');

      if (latestVersionStr.isEmpty || minRequiredVersionStr.isEmpty) {
        debugPrint('VersionCheck: Remote Config keys missing or empty');
        return UpdateType.none;
      }

      if (latestVersionStr.isEmpty || minRequiredVersionStr.isEmpty) {
        return UpdateType.none;
      }

      final latestVersion = _parseVersion(latestVersionStr);
      final minRequiredVersion = _parseVersion(minRequiredVersionStr);

      debugPrint('VersionCheck: Parsed Local: $currentVersion');
      debugPrint('VersionCheck: Parsed Latest: $latestVersion');
      debugPrint('VersionCheck: Parsed Min: $minRequiredVersion');

      if (currentVersion < minRequiredVersion) {
        debugPrint('VersionCheck: Result -> Force Update (Version < Min)');
        return UpdateType.force;
      }

      if (forceUpdateRemote && currentVersion < latestVersion) {
        return UpdateType.force;
      }

      if (currentVersion < latestVersion) {
        return UpdateType.soft;
      }

      debugPrint('VersionCheck: Result -> None');
      return UpdateType.none;
    } on Exception catch (e) {
      debugPrint('VersionCheck: Error -> $e');
      return UpdateType.none;
    }
  }

  void launchStore() {
    if (Platform.isAndroid) {
      PackageInfo.fromPlatform().then((info) {
        launchUrl(
          Uri.parse('https://play.google.com/store/apps/details?id=${info.packageName}'),
          mode: LaunchMode.externalApplication,
        );
      });
    } else if (Platform.isIOS) {
      launchUrl(
        Uri.parse('https://apps.apple.com/us/app/demal/id6758624069'),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  int _parseVersion(String version) {
    final cleanVersion = version.replaceAll(RegExp(r'[^\d.]'), '');
    final parts = cleanVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    var res = 0;
    if (parts.isNotEmpty) res += parts[0] * 1000000;
    if (parts.length > 1) res += parts[1] * 1000;
    if (parts.length > 2) res += parts[2];

    return res;
  }
}
