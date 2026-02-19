import 'package:core/core.dart';

abstract class RemoteConfigRepository {
  Stream<RemoteConfigModel> watch();
  Future<RemoteConfigModel> fetch();
}
