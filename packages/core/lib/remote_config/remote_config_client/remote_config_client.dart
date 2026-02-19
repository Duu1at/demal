import 'package:core/core.dart';

abstract class RemoteConfigClient {
  Stream<void> get updatesStream;
  Future<void> setUp(int currentBuildNumber);
  Future<void> refresh();
  Future<RemoteConfigModel> getConfig();
}
