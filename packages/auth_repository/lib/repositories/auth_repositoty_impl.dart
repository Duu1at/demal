import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
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
    await authLocalDataSource.deleteAccount();
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

  @override
  bool getOnboardingStatus() {
    return authLocalDataSource.getOnboardingStatus();
  }

  @override
  Future<void> saveOnboardingStatus(bool completed) async {
    await authLocalDataSource.saveOnboardingStatus(completed);
  }

  @override
  RoleEnum? getRole() {
    return authLocalDataSource.getRole();
  }

  @override
  Future<void> setRole(RoleEnum role) async {
    await authLocalDataSource.setRole(role);
  }
}
