import 'package:api_client/api_client.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:meta/meta.dart';

@immutable
class AuthRemoteDataSource {
  const AuthRemoteDataSource({
    required this.client,
    required this.supabaseGoogleSignService,
    required this.supabaseAppleSignService,
  });

  final ApiClient client;
  final SupabaseGoogleSignService supabaseGoogleSignService;
  final SupabaseAppleSignService supabaseAppleSignService;

  Future<String> sendOtp(String email) async {
    final result = await client.postResponse<Map<String, dynamic>>(
      '/api/v1/auth/send-otp',
      data: {'email': email},
    );

    return result.data?['message'] as String;
  }

  Future<String> verifyOtp(String email, String otpCode) {
    return client
        .postResponse<Map<String, dynamic>>(
          '/api/v1/auth/verify-otp',
          data: {
            'email': email,
            'otp_code': otpCode,
          },
        )
        .then((value) => value.data?['auth_token'] as String);
  }

  Future<String?> signInWithGoogle() async {
    try {
      final googleSignIn = await supabaseGoogleSignService.signInWithGoogle();
      final user = googleSignIn?.user;
      final session = googleSignIn?.session;

      if (user == null || session == null) return null;

      final googleAuthUserParams = GoogleAuthUserParams(
        accessToken: session.accessToken,
        userId: user.id,
        email: user.email ?? '',
        fullName: user.userMetadata?['full_name'] as String? ?? '',
        avatarUrl: user.userMetadata?['avatar_url'] as String?,
        phoneNumber: user.phone,
      );

      return client
          .postResponse<Map<String, dynamic>>(
            '/api/v1/auth/google',
            data: googleAuthUserParams.toJson(),
          )
          .then((value) => value.data?['auth_token'] as String?);
    } on Object catch (e, s) {
      throw AuthException(e, s);
    }
  }

  Future<String?> signInWithApple() async {
    try {
      final authResponse = await supabaseAppleSignService.signInWithApple();
      final user = authResponse?.user;
      final session = authResponse?.session;

      if (user == null || session == null) return null;

      final appleAuthUserParams = AppleAuthUserParams(
        accessToken: session.accessToken,
        userId: user.id,
        email: user.email ?? '',
        fullName: user.userMetadata?['full_name'] as String?,
        phoneNumber: user.phone,
      );

      return client
          .postResponse<Map<String, dynamic>>(
            '/api/v1/auth/apple',
            data: appleAuthUserParams.toJson(),
          )
          .then((value) => value.data?['auth_token'] as String?);
    } on Object catch (e, s) {
      throw AuthException(e, s);
    }
  }

  Future<void> deleteAccount() async {
    await client.delete<void>('/api/v1/users/account');

    try {
      await supabaseGoogleSignService.deleteAccount();
    } on Object catch (_) {}

    try {
      await supabaseAppleSignService.deleteAccount();
    } on Object catch (_) {}
  }

  Future<void> logOut() async {
    try {
      await supabaseGoogleSignService.logOut();
    } on Object catch (_) {}

    try {
      await supabaseAppleSignService.logOut();
    } on Object catch (_) {}
  }
}
