import 'package:auth_repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
class AuthLocalDataSource {
  const AuthLocalDataSource(this.storage);
  final PreferencesStorage storage;

  Future<void> clearStorage() async {
    await storage.clear();
  }

  String? getToken() {
    return storage.readString(key: AuthStorageKey.tokenKey);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: AuthStorageKey.tokenKey);
  }

  Future<void> saveToken(String token) async {
    await storage.writeString(
      key: AuthStorageKey.tokenKey,
      value: token,
    );
  }
}
