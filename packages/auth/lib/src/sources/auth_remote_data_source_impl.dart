import 'dart:convert';
import 'package:auth/src/exceptions/auth_exception.dart';
import 'package:auth/src/models/auth_login_model.dart';
import 'package:auth/src/sources/auth_data_source.dart';
import 'package:core/either/either.dart';
import 'package:core/keys/storage_keys.dart';
import 'package:core/network/remote_client.dart';
import 'package:meta/meta.dart';
import 'package:storage/storage.dart';

@immutable
final class AuthRemoteDataSourceImpl implements AuthDataSource {
  const AuthRemoteDataSourceImpl({required this.client, required this.storage});

  final RemoteClient client;
  final PreferencesStorage storage;

  @override
  Future<bool> deleteAccount() async {
    try {
      await Future.wait([
        storage.delete(key: StorageKeys.tokenKey),
        storage.delete(key: StorageKeys.userDataKey),
        storage.delete(key: StorageKeys.phoneNumberKey),
      ]);
      return true;
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  @override
  String? getToken() {
    try {
      return storage.readString(key: StorageKeys.tokenKey);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  @override
  Future<bool> logOut() {
    try {
      return storage.delete(key: StorageKeys.tokenKey);
    } catch (e, s) {
      throw StorageException(e, s);
    }
  }

  @override
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
      if (either is Right) {
        await storage.writeString(
          key: StorageKeys.phoneNumberKey,
          value: "+996$phoneNumber",
        );
      }
      return either;
    } catch (e) {
      return Left(AuthException(message: e.toString()));
    }
  }

  @override
  AuthLoginModel? getUserData() {
    final jsonString = storage.readString(key: StorageKeys.userDataKey);
    if (jsonString == null) return null;
    final Map<String, dynamic> json = jsonDecode(jsonString);

    return AuthLoginModel.fromJson(json);
  }

  @override
  Future<Either<AuthLoginModel, Exception>> verifyOtp(
    String phoneNumber,
    String otpCode,
  ) async {
    try {
      final response = await client.post(
        '/auth/verify-otp',
        body: {"phone_number": "+996$phoneNumber", "otp_code": otpCode},
      );

      final either = response.fold(
        (l) => Left<AuthLoginModel, Exception>(l),
        (r) => Right<AuthLoginModel, Exception>(r),
      );

      if (either is Right) {
        final r = (either as Right).value as AuthLoginModel;
        final jsonStringData = jsonEncode(r.toJson());
        await storage.writeString(
          key: StorageKeys.userDataKey,
          value: jsonStringData,
        );
        await storage.writeString(
          key: StorageKeys.tokenKey,
          value: r.authToken,
        );
      }

      return either;
    } catch (e) {
      return Left(AuthException(message: e.toString()));
    }
  }

  @override
  String? getPhoneNumver() =>
      storage.readString(key: StorageKeys.phoneNumberKey);
}
