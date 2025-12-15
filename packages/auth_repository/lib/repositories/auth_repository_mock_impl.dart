import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthRepositoryeMockImpl implements AuthRepository {
  const AuthRepositoryeMockImpl();

  @override
  Future<void> deleteAccount() async {
    await Future.delayed(const Duration(milliseconds: 50), () {});
  }

  @override
  String? getToken() {
    return 'token';
  }

  @override
  Future<void> logOut() async {
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Future<String> sendOtp(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    return 'Succes';
  }

  @override
  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode, String role) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    const user = UserModel(
      role: RoleEnum.CLIENT,
      fullName: 'Duulat',
      createdAt: '',
      userId: 'testId',
      phoneNumber: '+996 702 31 36 11',
      partnerProfile: null,
    );
    const authModel = AuthLoginModel(
      success: true,
      authToken: 'test',
      isNewUser: false,
      user: user,
    );
    return authModel;
  }

  @override
  bool getOnboardingStatus() {
    return true;
  }

  @override
  Future<void> saveOnboardingStatus(bool completed) async {
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  RoleEnum? getRole() {
    return RoleEnum.CLIENT;
  }

  @override
  Future<void> setRole(RoleEnum role) async {}
}
