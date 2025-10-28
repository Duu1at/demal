import 'package:auth/src/models/auth_login_model.dart';
import 'package:auth/src/models/user_model.dart';
import 'package:auth/src/sources/auth_data_source.dart';
import 'package:core/either/either.dart';
import 'package:core/network/remote_client.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class AuthRemoteDataSourceImpl implements AuthDataSource {
  const AuthRemoteDataSourceImpl({required this.client, required this.storage});

  final RemoteClient client;
  final PreferencesStorage storage;

  @override
  Future<bool> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  String? getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<bool> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {
    final response = await client.post(
      '/auth/send-otp',
      body:{
        "phone_number": "+996555123456"
      } 

    );
  }

  @override
  UserModel? getUserData() {
    // TODO: implement saveUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  ) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}
