import 'package:auth/src/exceptions/auth_exception.dart';
import 'package:auth/src/models/auth_login_model.dart';
import 'package:auth/src/repositories/auth_repository.dart';
import 'package:auth/src/sources/auth_data_source.dart';
import 'package:core/either/either.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.authDataSource);

  final AuthDataSource authDataSource;

  @override
  String? getToken() => authDataSource.getToken();

  @override
  AuthLoginModel? getUserData() => authDataSource.getUserData();

  @override
  Future<void> deleteAccount() async {
    try {
      final response = await authDataSource.deleteAccount();
    } catch (e) {
      Left(AuthException(message: e.toString()));
    }
  }

  @override
  Future<void> logOut() async {
    try {
      final res = await authDataSource.logOut();
    } catch (e) {
      Left(AuthException(message: e.toString()));
    }
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {
    try {
      final response = await authDataSource.sendOtp(phoneNumber);
    } catch (e) {
      Left(AuthException(message: e.toString()));
    }
  }

  @override
  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  ) async {
    try {
      final res = await authDataSource.verifyOtp(phoneNumber, otpCode);
      return res.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      return Left(AuthException(message: e.toString()));
    }
  }
}
