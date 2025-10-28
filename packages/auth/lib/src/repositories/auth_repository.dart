import 'package:auth/src/models/auth_login_model.dart';
import 'package:auth/src/models/user_model.dart';
import 'package:core/either/either.dart';

abstract class AuthRepository {
  String? getToken();
  UserModel? getUserData();
  Future<void> sendOtp(String phoneNumber);
  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  );
  Future<void> deleteAccount();
  Future<void> logOut();
}
