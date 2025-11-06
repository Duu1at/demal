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
  String? getToken() => authLocalDataSource.getToken();

  @override
  AuthLoginModel? getUserData() => authLocalDataSource.getUserData();

  @override
  Future<void> deleteAccount() async => authLocalDataSource.deleteAccount();

  @override
  Future<void> logOut() async {
    try {
      authLocalDataSource.logOut();
    } catch (e, s) {
      throw AuthException(e, s);
    }
  }

  @override
  Future<String> sendOtp(String phoneNumber) =>
      authRemoteDataSource.sendOtp(phoneNumber);

  @override
  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode) async {
    final result = await authRemoteDataSource.verifyOtp(phoneNumber, otpCode);
    await authLocalDataSource.saveUserData(result);
    return result;
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
  Role? getRole() {
    return authLocalDataSource.getRole();
  }

  @override
  Future<void> setRole(Role role) async {
    await authLocalDataSource.setRole(role);
  }
}
