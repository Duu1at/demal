import 'package:core/core.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

@immutable
final class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  @override
  Future<UserModel> getProfile() async {
    final profile = await remoteDataSource.getProfile();
    await localDataSource.setProfileData(profile);
    return profile;
  }

  @override
  Future<UserModel> updateProfile(ProfileUpdateParam param) async {
    final profile = await remoteDataSource.updateProfile(param);
    await localDataSource.setProfileData(profile);
    return profile;
  }

  @override
  Future<PartnerVerifyStatusModel> getPartnerVerifyStatus() {
    return remoteDataSource.getPartnerVerifyStatus();
  }

  @override
  Future<PartnerProfileModel> updatePartnerProfile(PartnerProfileParam param) async {
    final partnerProfile = await remoteDataSource.updatePartnerProfile(param);
    await getProfile();
    return partnerProfile;
  }

  @override
  UserModel? getProfileFromLocal() {
    return localDataSource.getProfileData();
  }

  @override
  Future<void> deleteProfileData() async {
    await localDataSource.deleteProfileData();
  }
}
