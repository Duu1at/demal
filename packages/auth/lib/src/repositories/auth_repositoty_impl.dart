import 'package:auth/auth.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.authRemoteDataSource,
  });

  final AuthLocalDataSource authLocalDataSource;
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
  Future<String> sendOtp(String phoneNumber) =>
      authRemoteDataSource.sendOtp(phoneNumber);

  @override
  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode) {
    return authRemoteDataSource.verifyOtp(phoneNumber, otpCode);
  }

  @override
  String? getPhoneNumber() => authLocalDataSource.getPhoneNumber();
}
