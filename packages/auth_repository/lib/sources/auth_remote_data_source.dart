import 'package:api_client/api_client.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthRemoteDataSource {
  const AuthRemoteDataSource(this.client);

  final ApiClient client;

  Future<String> sendOtp(String phoneNumber) async {
    final result = await client.postResponse<Map<String, dynamic>>(
      '/api/v1/auth/send-otp',
      data: {'phone_number': '+996$phoneNumber'},
    );

    return result.data?['message'] as String;
  }

  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode, String role) {
    return client.postType(
      '/api/v1/auth/verify-otp',
      data: {'phone_number': '+996$phoneNumber', 'otp_code': otpCode},
      params: PostApiParams(
        options: Options(headers: {'x-app-role': role}),
      ),
      fromJson: AuthLoginModel.fromJson,
    );
  }
}
