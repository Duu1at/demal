import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';

@immutable
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this.client);

  final ApiClient client;

  Future<String> sendOtp(String email) async {
    final result = await client.postResponse<Map<String, dynamic>>(
      '/api/v1/auth/send-otp',
      data: {'email': email},
    );

    return result.data?['message'] as String;
  }

  Future<String> verifyOtp(
    String email,
    String otpCode,
  ) {
    return client
        .postResponse<Map<String, dynamic>>(
          '/api/v1/auth/verify-otp',
          data: {'email': email, 'otp_code': otpCode},
        )
        .then((value) => value.data?['auth_token'] as String);
  }
}
