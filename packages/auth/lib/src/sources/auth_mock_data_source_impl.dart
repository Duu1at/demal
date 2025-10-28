import 'package:auth/src/models/auth_login_model.dart';
import 'package:auth/src/models/user_model.dart';
import 'package:auth/src/sources/auth_data_source.dart';
import 'package:core/either/either.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class AuthMockDataSourceImpl implements AuthDataSource {
  const AuthMockDataSourceImpl(this.storage);
  final PreferencesStorage storage;

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
  Future<void> sendOtp(String phoneNumber) async {
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  UserModel? getUserData() {
    const user = UserModel(
      success: true,
      role: Role.client,
      fullName: 'Duulat',
      createdAt: '',
      userId: 'testId',
      phoneNumber: '+996 702 31 36 11',
    );
    return user;
  }

  @override
  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  ) async {
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
    return const Right(authModel);
  }
}
