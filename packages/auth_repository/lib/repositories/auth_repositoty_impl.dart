import 'package:auth_repository/auth_repository.dart';
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
  String? getToken() {
    return authLocalDataSource.getToken();
  }

  @override
  Future<void> deleteAccount() async {
    await authRemoteDataSource.deleteAccount();
    await authLocalDataSource.clearStorage();
  }

  @override
  Future<void> logOut() async {
    await authRemoteDataSource.logOut();
    await authLocalDataSource.deleteToken();
  }

  @override
  Future<void> signInWithGoogle() async {
    final token = await authRemoteDataSource.signInWithGoogle();
    if (token == null) {
      throw const AuthException('No token found.');
    }
    await authLocalDataSource.saveToken(token);
  }

  @override
  Future<String> sendOtp(String email) {
    return authRemoteDataSource.sendOtp(email);
  }

  @override
  Future<String> verifyOtp(
    String email,
    String otpCode,
  ) async {
    final res = await authRemoteDataSource.verifyOtp(email, otpCode);
    await authLocalDataSource.saveToken(res);
    return res;
  }
}
