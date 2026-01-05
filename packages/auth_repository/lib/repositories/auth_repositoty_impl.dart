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
    await authRemoteDataSource.deleteAccount().then(
      (value) => authLocalDataSource.clearStorage(),
    );
  }

  @override
  Future<void> logOut() async {
    await authLocalDataSource.logOut();
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
