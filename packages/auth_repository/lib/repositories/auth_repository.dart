import 'package:auth_repository/auth_repository.dart';

abstract class AuthRepository {
  String? getToken();
  AuthLoginModel? getUserData();
  Future<String> sendOtp(String phoneNumber);
  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode);
  Future<void> deleteAccount();
  Future<void> logOut();
  Future<void> saveOnboardingStatus(bool completed);
  bool getOnboardingStatus();
  Future<void> setRole(Role role);
  Role? getRole();
}
