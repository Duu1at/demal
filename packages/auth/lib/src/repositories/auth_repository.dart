import 'package:auth/src/models/auth_login_model.dart';
import 'package:core/either/either.dart';

abstract class AuthRepository {
  String? getToken();
  AuthLoginModel? getUserData();
  Future<void> sendOtp(String phoneNumber);
  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  );
  Future<void> deleteAccount();
  Future<void> logOut();
  String? getPhoneNumber();
}
