import 'package:auth/src/exceptions/auth_exception.dart';
import 'package:auth/src/models/auth_login_model.dart';
import 'package:core/either/either.dart';
import 'package:core/network/remote_client.dart';
import 'package:meta/meta.dart';

@immutable
final class AuthRemoteDataSource {
  const AuthRemoteDataSource(this.client);

  final RemoteClient client;

  Future<Either<String, Exception>> sendOtp(String phoneNumber) async {
    try {
      final response = await client.post(
        '/auth/send-otp',
        body: {"phone_number": "+996$phoneNumber"},
      );

      final either = response.fold(
        (l) => Left<String, Exception>(l),
        (r) => Right<String, Exception>(r),
      );
      return either;
    } catch (e) {
      return Left(AuthException(message: e.toString()));
    }
  }

  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  ) async {
    try {
      final response = await client.post(
        '/auth/verify-otp',
        body: {"phone_number": "+996$phoneNumber", "otp_code": otpCode},
      );

      return response.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      return Left(AuthException(message: e.toString()));
    }
  }
}
