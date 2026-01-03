import 'package:core/core.dart';
import 'package:profile_repository/profile_repository.dart';

abstract class ProfileRepository {

  Future<UserModel> getProfile();
  Future<UserModel> updateProfile(ProfileUpdateParam param);
  UserModel? getProfileFromLocal();

  Future<UserModel> upgradeToPartner();
  Future<PartnerVerifyStatusModel> getPartnerVerifyStatus();
  Future<void> deleteProfileData();
  Future<PartnerProfileModel> updatePartnerProfile(PartnerProfileParam param);
}
