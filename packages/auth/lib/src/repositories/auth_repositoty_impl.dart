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
  void deleteAccount() => authLocalDataSource.deleteAccount();

  @override
  void logOut() => authLocalDataSource.logOut();

  @override
  Future<String> sendOtp(String phoneNumber) =>
      authRemoteDataSource.sendOtp(phoneNumber);

  @override
  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode) async {
    final result = await authRemoteDataSource.verifyOtp(phoneNumber, otpCode);
   await authLocalDataSource.saveUserData(result);
    return result;
  }
}
