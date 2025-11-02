import '../../auth_repository.dart';

abstract class AuthRepository {
  String? getToken();
  AuthLoginModel? getUserData();
  Future<void> sendOtp(String phoneNumber);
  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode);
  void deleteAccount();
  void logOut();
  Future<void> saveOnboardingStatus(bool completed);
  bool getOnboardingStatus();
  Future<void> setRole(Role role);
 Role? getRole();
}
