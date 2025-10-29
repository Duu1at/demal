import 'dart:convert';
import 'package:auth/src/models/auth_login_model.dart';
import 'package:core/keys/storage_keys.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class AutLocalDataSource {
  const AutLocalDataSource(this.storage);
  final PreferencesStorage storage;

  Future<bool> deleteAccount() async {
    try {
      await Future.wait([
        storage.delete(key: StorageKeys.tokenKey),
        storage.delete(key: StorageKeys.userDataKey),
        storage.delete(key: StorageKeys.phoneNumberKey),
      ]);
      return true;
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

  Future<bool> logOut() {
    try {
      return storage.delete(key: StorageKeys.tokenKey);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  AuthLoginModel? getUserData() {
    final jsonString = storage.readString(key: StorageKeys.userDataKey);
    if (jsonString == null) return null;
    final Map<String, dynamic> json = jsonDecode(jsonString);

    return AuthLoginModel.fromJson(json);
  }

  String? getPhoneNumver() =>
      storage.readString(key: StorageKeys.phoneNumberKey);
}
