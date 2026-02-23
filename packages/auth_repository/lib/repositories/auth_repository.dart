abstract class AuthRepository {
  String? getToken();
  Future<String> sendOtp(String email);
  Future<String> verifyOtp(String email, String otpCode);
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> deleteAccount();
  Future<void> logOut();
}
