import 'package:auth/src/models/auth_login_model.dart';
import 'package:auth/src/models/user_model.dart';
import 'package:core/either/either.dart';

abstract class AuthDataSource {
  String? getToken();
  Future<void> sendOtp(String phoneNumber);
  Future<Either<AuthLoginModel, Exception>> verifyOtp(String phoneNumber, String otpCode);
  UserModel? getUserData();
  Future<void> deleteAccount();
  Future<void> logOut();
}
