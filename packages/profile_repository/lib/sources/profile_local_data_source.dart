import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:storage/storage.dart';

@immutable
final class ProfileLocalDataSource {
  const ProfileLocalDataSource(this.storage);

  final PreferencesStorage storage;

  static const String clientProfileKey = 'client_profile';
  static const String partnerProfileKey = 'partner_profile';

  Future<void> setClientProfileData(ClientProfileModel data) async {
    final json = jsonEncode(data.toJson());
    await storage.writeString(key: clientProfileKey, value: json);
  }

  ClientProfileModel getClientProfileData() {
    final json = storage.readString(key: clientProfileKey) ?? '{}';
    return ClientProfileModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> setPartnerProfileData(PartnerProfileModel data) async {
    final json = jsonEncode(data.toJson());
    await storage.writeString(key: partnerProfileKey, value: json);
  }

  PartnerProfileModel getPartnerProfileData() {
    final json = storage.readString(key: partnerProfileKey) ?? '{}';
    return PartnerProfileModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
}
