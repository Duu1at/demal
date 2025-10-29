import 'package:auth/auth.dart';
import 'package:auth/src/models/auth_login_model.dart';
import 'package:core/either/either.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.authRemoteDataSource,
  });

  final AutLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  @override
  String? getToken() => authLocalDataSource.getToken();

  @override
  AuthLoginModel? getUserData() => authLocalDataSource.getUserData();

  @override
  Future<void> deleteAccount() => authLocalDataSource.deleteAccount();

  @override
  Future<void> logOut() => authLocalDataSource.logOut();

  @override
  Future<void> sendOtp(String phoneNumber) =>
      authRemoteDataSource.sendOtp(phoneNumber);

  @override
  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  ) async {
    try {
      final res = await authRemoteDataSource.verifyOtp(phoneNumber, otpCode);
      return res.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      return Left(AuthException(message: e.toString()));
    }
  }

  @override
  String? getPhoneNumber() => authLocalDataSource.getPhoneNumver();
}
