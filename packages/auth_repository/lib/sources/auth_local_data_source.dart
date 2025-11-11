import 'dart:convert';

import 'package:auth_repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class AuthLocalDataSource {
  const AuthLocalDataSource(this.storage);
  final PreferencesStorage storage;

  Future<void> deleteAccount() async {
    await Future.wait([
      storage.delete(key: AuthStorageKey.tokenKey),
      storage.delete(key: AuthStorageKey.userDataKey),
      storage.delete(key: AuthStorageKey.roleKey),
    ]);
  }

  String? getToken() {
    return storage.readString(key: AuthStorageKey.tokenKey);
  }

  Future<void> logOut() async {
    await storage.delete(key: AuthStorageKey.tokenKey);
  }

  AuthLoginModel? getUserData() {
    final jsonString = storage.readString(key: AuthStorageKey.userDataKey);
    if (jsonString == null) return null;

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return AuthLoginModel.fromJson(json);
  }

  Future<void> saveUserData(AuthLoginModel data) async {
    await Future.wait([
      storage.writeString(
        key: AuthStorageKey.tokenKey,
        value: data.authToken,
      ),
      storage.writeString(
        key: AuthStorageKey.userDataKey,
        value: jsonEncode(data.toJson()),
      ),
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

  Future<void> setRole(Role role) async {
    await storage.writeString(
      key: AuthStorageKey.roleKey,
      value: role.toJson(),
    );
  }

  Role? getRole() {
    final roleString = storage.readString(key: AuthStorageKey.roleKey);
    if (roleString == null) return null;
    return Role.fromString(roleString);
  }
}
