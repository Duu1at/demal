import 'package:auth/src/models/auth_login_model.dart';
import 'package:core/either/either.dart';

abstract class AuthDataSource {
  String? getToken();
  String? getPhoneNumver();
  Future<Either<String, Exception>> sendOtp(String phoneNumber);
  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  );
  AuthLoginModel? getUserData();
  Future<void> deleteAccount();
  Future<void> logOut();
}
