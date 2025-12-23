import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:storage/storage.dart';

@immutable
final class ProfileLocalDataSource {
  const ProfileLocalDataSource(this.storage);

  final PreferencesStorage storage;

  static const String profileKey = 'profile';

  Future<void> setProfileData(ProfileModel data) async {
    final json = jsonEncode(data.toJson());
    await storage.writeString(key: profileKey, value: json);
  }

  ProfileModel getProfileData() {
    final json = storage.readString(key: profileKey);
    return ProfileModel.fromJson(jsonDecode(json ?? '{}') as Map<String, dynamic>);
  }

  Future<void> deleteProfileData() async {
    await storage.delete(key: profileKey);
  }
}
