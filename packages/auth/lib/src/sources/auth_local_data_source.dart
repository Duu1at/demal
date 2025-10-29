import 'dart:convert';
import 'package:auth/src/models/auth_login_model.dart';
import 'package:core/keys/storage_keys.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class AuthLocalDataSource {
  const AuthLocalDataSource(this.storage);
  final PreferencesStorage storage;

  Future<void> deleteAccount() async {
    await Future.wait([
      storage.delete(key: StorageKeys.tokenKey),
      storage.delete(key: StorageKeys.userDataKey),
      storage.delete(key: StorageKeys.phoneNumberKey),
    ]);
  }

  String? getToken() {
    return storage.readString(key: StorageKeys.tokenKey);
  }

  Future<void> logOut() async {
    await storage.delete(key: StorageKeys.tokenKey);
  }

  AuthLoginModel? getUserData() {
    final jsonString = storage.readString(key: StorageKeys.userDataKey);
    if (jsonString == null) return null;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    final user = AuthLoginModel.fromJson(json);
    return user;
  }

  String? getPhoneNumber() {
    final number = storage.readString(key: StorageKeys.phoneNumberKey);
    return number;
  }
}
