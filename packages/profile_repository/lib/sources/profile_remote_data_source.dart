import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

@immutable
final class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<ProfileModel> getProfile() {
    return apiClient.getType<ProfileModel>(
      '/api/v1/users/me',
      fromJson: ProfileModel.fromJson,
    );
  }

  Future<ProfileModel> updateProfile(ProfileUpdateParam param) {
    return apiClient.patchType<ProfileModel>(
      '/api/v1/users/profile',
      data: param.toJson(),
      fromJson: ProfileModel.fromJson,
    );
  }

  Future<PartnerVerifyStatusModel> getPartnerVerifyStatus() {
    return apiClient.getType<PartnerVerifyStatusModel>(
      '/api/v1/partners/verification-status',
      fromJson: PartnerVerifyStatusModel.fromJson,
    );
  }

  Future<PartnerProfileModel> updatePartnerProfile(PartnerProfileParam param) async {
    final response = await apiClient.postResponse<Map<String, dynamic>>(
      '/api/v1/partners/profile',
      data: param.toJson(),
    );
    return PartnerProfileModel.fromJson(response.data?['profile'] as Map<String, dynamic>);
  }
}
