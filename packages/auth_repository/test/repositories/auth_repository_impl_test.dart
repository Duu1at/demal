import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthLocalDataSource localDataSource;
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl authRepository;

  setUp(() {
    localDataSource = MockAuthLocalDataSource();
    remoteDataSource = MockAuthRemoteDataSource();
    authRepository = AuthRepositoryImpl(
      authLocalDataSource: localDataSource,
      authRemoteDataSource: remoteDataSource,
    );
  });

  group('AuthRepositoryImpl', () {
    const phoneNumber = '123456789';
    const otpCode = '1234';
    const token = 'test_token';
    const loginModel = AuthLoginModel(
      success: true,
      authToken: token,
      isNewUser: false,
      user: UserModel(),
    );

    test('verifyOtp saves token when request is successful', () async {
      when(() => remoteDataSource.verifyOtp(phoneNumber, otpCode)).thenAnswer((_) async => loginModel);
      when(() => localDataSource.saveToken(any())).thenAnswer((_) async {});

      final result = await authRepository.verifyOtp(phoneNumber, otpCode);

      expect(result, equals(loginModel));
      verify(() => localDataSource.saveToken(token)).called(1);
    });

    test('verifyOtp does not save token when request indicates failure', () async {
      const failureModel = AuthLoginModel(
        success: false,
        authToken: '',
        isNewUser: false,
        user: UserModel(),
      );

      when(() => remoteDataSource.verifyOtp(phoneNumber, otpCode)).thenAnswer((_) async => failureModel);

      final result = await authRepository.verifyOtp(phoneNumber, otpCode);

      expect(result, equals(failureModel));
      verifyNever(() => localDataSource.saveToken(any()));
    });
  });
}
