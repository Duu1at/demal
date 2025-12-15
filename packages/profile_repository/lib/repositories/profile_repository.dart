import 'package:core/core.dart';
import 'package:profile_repository/profile_repository.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(ProfileUpdateParam param);
  ProfileModel getProfileFromLocal();

  Future<PartnerVerifyStatusModel> getPartnerVerifyStatus();
  Future<PartnerProfileModel> updatePartnerProfile(PartnerProfileParam param);
}
