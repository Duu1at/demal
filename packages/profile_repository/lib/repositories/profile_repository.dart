import 'package:profile_repository/profile_repository.dart';

abstract class ProfileRepository {
  Future<ClientProfileModel> getClientProfile();
  Future<ClientProfileModel> updateClientProfile(ClientUpdateProfileParam clientUpdateProfileParam);

  Future<PartnerVerifyStatusModel> getPartnerVerifyStatus();
  Future<PartnerProfileModel> updatePartnerProfile(PartnerUpdateProfileParam updatePartnerProfileParam);
}
