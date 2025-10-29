import 'package:auth/src/models/auth_login_model.dart';
import 'package:core/either/either.dart';

abstract class AuthDataSource {
  String? getToken();
  Future<void> sendOtp(String phoneNumber);
  Future<Either<AuthLoginModel, Exception>> verifyOtp(String phoneNumber, String otpCode);
  AuthLoginModel? getUserData();
  Future<void> deleteAccount();
  Future<void> logOut();
}
