import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

@immutable
final class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<ClientProfileModel> getClientProfile() {
    return apiClient.getType<ClientProfileModel>(
      '/api/v1/users/me',
      fromJson: ClientProfileModel.fromJson,
    );
  }

  Future<ClientProfileModel> updateClientProfile(ClientUpdateProfileParam clientUpdateProfileParam) {
    return apiClient.patchType<ClientProfileModel>(
      '/api/v1/users/profile',
      data: clientUpdateProfileParam.toJson(),
      fromJson: ClientProfileModel.fromJson,
    );
  }

  Future<PartnerVerifyStatusModel> getPartnerVerifyStatus() {
    return apiClient.getType<PartnerVerifyStatusModel>(
      '/api/v1/partners/verification-status',
      fromJson: PartnerVerifyStatusModel.fromJson,
    );
  }

  Future<PartnerProfileModel> updatePartnerProfile(PartnerUpdateProfileParam partnerUpdateProfileParam) {
    return apiClient.postType<PartnerProfileModel>(
      '/api/v1/partners/profile',
      data: partnerUpdateProfileParam.toJson(),
      fromJson: PartnerProfileModel.fromJson,
    );
  }
}
