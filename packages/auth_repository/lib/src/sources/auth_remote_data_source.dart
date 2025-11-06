import 'package:auth_repository/src/models/auth_login_model.dart';
import 'package:core/network/remote_client.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthRemoteDataSource {
  const AuthRemoteDataSource(this.client);

  final RemoteClient client;

  Future<String> sendOtp(String phoneNumber) async {
    final result = await client.post<Map<String, dynamic>>(
      '/auth/send-otp',
      body: {'phone_number': '+996$phoneNumber'},
    );

    return result['message'] as String;
  }

  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode) async {
    final result = await client.post(
      '/auth/verify-otp',
      body: {'phone_number': '+996$phoneNumber', 'otp_code': otpCode},
      fromJson: AuthLoginModel.fromJson,
    );
    return result;
  }
}
