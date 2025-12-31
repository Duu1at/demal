import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';
import 'package:profile_repository/profile_repository.dart';

@immutable
final class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<UserModel> getProfile() async {
    final response = await apiClient.getResponse<Map<String, dynamic>>(
      '/api/v1/users/me',
    );
    return UserModel.fromJson(response.data?['user'] as Map<String, dynamic>);
  }

  Future<UserModel> updateProfile(ProfileUpdateParam param) async {
    final response = await apiClient.patchResponse<Map<String, dynamic>>(
      '/api/v1/users/profile',
      data: param.toJson(),
    );
    return UserModel.fromJson(response.data?['user'] as Map<String, dynamic>);
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
