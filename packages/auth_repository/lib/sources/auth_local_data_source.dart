
import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class AuthLocalDataSource {
  const AuthLocalDataSource(this.storage);
  final PreferencesStorage storage;

  Future<void> deleteAccount() async {
    await logOut();
  }

  String? getToken() {
    return storage.readString(key: AuthStorageKey.tokenKey);
  }

  Future<void> logOut() async {
    await Future.wait([
      storage.delete(key: AuthStorageKey.tokenKey),
      storage.delete(key: AuthStorageKey.roleKey),
    ]);
  }

  Future<void> saveOnboardingStatus(bool completed) async {
    await storage.writeBool(
      key: AuthStorageKey.onboardingKey,
      value: completed,
    );
  }

  bool getOnboardingStatus() {
    return storage.readBool(key: AuthStorageKey.onboardingKey) ?? false;
  }

  Future<void> setRole(RoleEnum role) async {
    await storage.writeString(
      key: AuthStorageKey.roleKey,
      value: role.name,
    );
  }

  RoleEnum? getRole() {
    final roleString = storage.readString(key: AuthStorageKey.roleKey);
    if (roleString == null) return null;
    try {
      return RoleEnum.values.byName(roleString);
    } on Object catch (_) {
      return null;
    }
  }
}
