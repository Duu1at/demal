import 'package:auth/src/models/auth_login_model.dart';

abstract class AuthRepository {
  String? getToken();
  String? getPhoneNumber();
  AuthLoginModel? getUserData();
  Future<void> sendOtp(String phoneNumber);
  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode);
  Future<void> deleteAccount();
  Future<void> logOut();
}
