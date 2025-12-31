import 'dart:convert';
import 'package:core/core.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class ProfileLocalDataSource {
  const ProfileLocalDataSource(this.storage);

  final PreferencesStorage storage;

  static const String profileKey = 'profile';

  Future<void> setProfileData(UserModel data) async {
    final json = jsonEncode(data.toJson());
    await storage.writeString(key: profileKey, value: json);
  }

  UserModel? getProfileData() {
    final json = storage.readString(key: profileKey);
    if (json == null) return null;
    return UserModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> deleteProfileData() async {
    await storage.delete(key: profileKey);
  }
}
