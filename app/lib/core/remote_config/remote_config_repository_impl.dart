import 'package:core/core.dart';

final class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  const RemoteConfigRepositoryImpl(this._client);

  final RemoteConfigClient _client;

  @override
  Stream<RemoteConfigModel> watch() {
    return _client.updatesStream.asyncMap((_) async {
      await _client.refresh();
      return _client.getConfig();
    });
  }

  @override
  Future<RemoteConfigModel> fetch() async {
    await _client.refresh();
    return _client.getConfig();
  }
}
