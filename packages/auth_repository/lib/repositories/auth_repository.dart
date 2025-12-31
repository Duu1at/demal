import 'package:core/core.dart';

abstract class AuthRepository {
  String? getToken();
  Future<String> sendOtp(String email);
  Future<String> verifyOtp(
    String email,
    String otpCode,
  );
  Future<void> deleteAccount();
  Future<void> logOut();
  Future<void> saveOnboardingStatus(bool completed);
  bool getOnboardingStatus();
  Future<void> setRole(RoleEnum role);
  RoleEnum? getRole();
}
