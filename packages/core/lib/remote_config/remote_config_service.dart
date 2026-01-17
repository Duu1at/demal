import 'dart:async';

abstract interface class RemoteConfigService {
  FutureOr<void> fetchAndActivate();

  String getString(String key);

  bool getBool(String key);

  int getInt(String key);

  double getDouble(String key);
}
