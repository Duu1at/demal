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
  Future<ClientProfileModel> getClientProfile() async {
    final clientProfile = await remoteDataSource.getClientProfile();
    await localDataSource.setClientProfileData(clientProfile);
    return clientProfile;
  }

  @override
  Future<ClientProfileModel> updateClientProfile(
    ClientUpdateProfileParam clientUpdateProfileParam,
  ) async {
    final clientProfile = await remoteDataSource.updateClientProfile(clientUpdateProfileParam);
    await localDataSource.setClientProfileData(clientProfile);
    return clientProfile;
  }

  @override
  Future<PartnerVerifyStatusModel> getPartnerVerifyStatus() {
    return remoteDataSource.getPartnerVerifyStatus();
  }

  @override
  Future<PartnerProfileModel> updatePartnerProfile(
    PartnerUpdateProfileParam updatePartnerProfileParam,
  ) {
    return remoteDataSource.updatePartnerProfile(updatePartnerProfileParam);
  }
}
