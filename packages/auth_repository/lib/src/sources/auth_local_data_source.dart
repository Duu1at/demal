import 'dart:convert';
import '../../auth_repository.dart';
import 'package:core/keys/storage_keys.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class AuthLocalDataSource {
  const AuthLocalDataSource(this.storage);
  final PreferencesStorage storage;

  void deleteAccount() {
    try {
      storage.delete(key: StorageKeys.tokenKey);
      storage.delete(key: StorageKeys.userDataKey);
      storage.delete(key: StorageKeys.roleKey);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  String? getToken() {
    try {
      return storage.readString(key: StorageKeys.tokenKey);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  void logOut() async {
    try {
      storage.delete(key: StorageKeys.tokenKey);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  AuthLoginModel? getUserData() {
    try {
      final jsonString = storage.readString(key: StorageKeys.userDataKey);
      if (jsonString == null) return null;

      final Map<String, dynamic> json = jsonDecode(jsonString);
      final user = AuthLoginModel.fromJson(json);
      return user;
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  Future<void> saveUserData(AuthLoginModel data) async {
    try {
      await storage.writeString(
        key: StorageKeys.tokenKey,
        value: data.authToken,
      );
      final jsonString = jsonEncode(data.toJson());
      await storage.writeString(
        key: StorageKeys.userDataKey,
        value: jsonString,
      );
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  Future<void> saveOnboardingStatus(bool completed) async {
    try {
      await storage.writeBool(key: StorageKeys.onboardingKey, value: completed);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  bool getOnboardingStatus() {
    try {
      return storage.readBool(key: StorageKeys.onboardingKey) ?? false;
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  Future<void> setRole(Role role) async {
    try {
      final roleString = role.toJson();
      await storage.writeString(key: StorageKeys.roleKey, value: roleString);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  Role? getRole() {
    try {
      final roleString = storage.readString(key: StorageKeys.roleKey);

      if (roleString == null) return null;

      return Role.fromString(roleString);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }
}
