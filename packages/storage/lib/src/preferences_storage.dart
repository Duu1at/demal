import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/src/interface/storage_exception.dart';

import 'interface/storage_interface_read.dart';

class PreferencesStorage implements StorageInterfaceRead {
  PreferencesStorage._(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  static Future<PreferencesStorage> getInstance([SharedPreferences? pref]) async =>
      PreferencesStorage._(pref ?? await SharedPreferences.getInstance());

  @override
  String? readString({required String key}) {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  bool? readBool({required String key}) {
    try {
      return _sharedPreferences.getBool(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  double? readDouble({required String key}) {
    try {
      return _sharedPreferences.getDouble(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  int? readInt({required String key}) {
    try {
      return _sharedPreferences.getInt(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  List<String>? readStringList({required String key}) {
    try {
      return _sharedPreferences.getStringList(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeString({required String key, required String value}) {
    try {
      return _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeBool({required String key, required bool value}) {
    try {
      return _sharedPreferences.setBool(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeDouble({required String key, required double value}) {
    try {
      return _sharedPreferences.setDouble(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeInt({required String key, required int value}) {
    try {
      return _sharedPreferences.setInt(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> writeStringList({required String key, required List<String> value}) {
    try {
      return _sharedPreferences.setStringList(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> delete({required String key}) async {
    try {
      return _sharedPreferences.remove(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> clear() {
    try {
      return _sharedPreferences.clear();
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }
}
