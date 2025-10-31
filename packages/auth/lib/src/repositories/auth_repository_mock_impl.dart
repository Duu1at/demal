import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthRepositoryeMockImpl implements AuthRepository {
  const AuthRepositoryeMockImpl();

  @override
  Future<void> deleteAccount() async {
    Future.delayed(const Duration(milliseconds: 50));
  }

  @override
  String? getToken() {
    return 'token';
  }

  @override
  Future<void> logOut() async {
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<Either<String, Exception>> sendOtp(String phoneNumber) async {
    Future.delayed(const Duration(seconds: 1));
    return const Right('Succes');
  }

  @override
  AuthLoginModel? getUserData() {
    const user = UserModel(
      success: true,
      role: Role.client,
      fullName: 'Duulat',
      createdAt: '',
      userId: 'testId',
      phoneNumber: '+996 702 31 36 11',
    );
    const data = AuthLoginModel(
      success: true,
      authToken: 'auth_token',
      isNewUser: false,
      user: user,
    );

    return data;
  }

  @override
  Future<AuthLoginModel> verifyOtp(String phoneNumber, String otpCode) async {
    Future.delayed(const Duration(seconds: 1));
    const user = UserModel(
      success: true,
      role: Role.client,
      fullName: 'Duulat',
      createdAt: '',
      userId: 'testId',
      phoneNumber: '+996 702 31 36 11',
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
  String? getPhoneNumber() {
    return '+996702313611';
  }
}
