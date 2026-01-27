import 'package:auth_repository/auth_repository.dart';
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
  Future<String> sendOtp(String email) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    return 'Succes';
  }

  @override
  Future<String> verifyOtp(
    String email,
    String otpCode,
  ) async {
    await Future.delayed(const Duration(seconds: 1), () {});

    return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3NzRjYjlkYS05YzI0LTQ0NWItYmY5My1iODVmZTZhN2ZlNmQiLCJlbWFpbCI6ImRib2xzdW5iZWt1dWx1QGdtYWlsLmNvbSIsInJvbGUiOiJDTElFTlQiLCJpYXQiOjE3NjcxMjE1NzMsImV4cCI6MTc2NzcyNjM3M30.GfDCfs92aEjCuWiAqgx6sa35lrXQpp7jXnowisyd0Uc';
  }

  @override
  Future<void> signInWithGoogle() {
    return Future.delayed(const Duration(seconds: 1), () {});
  }
}
