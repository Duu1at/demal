import 'package:core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> setUpRemoteConfig(
  RemoteConfigClient remoteConfigClient,
  PackageInfo packageInfo,
) async {
  final currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 100;

  await remoteConfigClient.setUp(currentBuildNumber);
}
