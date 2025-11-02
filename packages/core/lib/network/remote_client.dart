import 'dart:async';
import 'dart:io';
import 'package:core/di/injector.dart';
import 'package:core/network/exception/remote_exception.dart';
import 'package:core/network/network_client/network_client.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef FromJson<T> = T Function(Map<String, dynamic>);

typedef ResolveValue = String? Function();
typedef ResolveAppRole = String? Function();

class RemoteClient {
  RemoteClient({
    required this.dio,
    required this.network,
    this.token,
    this.resolveAppRole,
  }) {
    initilize();
  }

  final Dio dio;
  final NetworkClient network;
  final ResolveValue? token;
  final ResolveAppRole? resolveAppRole;

  void initilize() {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // options.headers['Content-Type'] = 'application/json; charset=utf-8';
          // options.headers['Accept'] = 'application/json';

          final appRole = resolveAppRole?.call();
          if (appRole != null) {
            options.headers['X-App-Type'] = appRole;
          }

          final resolvedToken = token?.call();
          if (resolvedToken != null) {
            options.headers['Authorization'] = 'Bearer $resolvedToken';
          }

          return handler.next(options);
        },
        onError: (error, handler) => handler.next(error),
        onResponse: (response, handler) => handler.next(response),
      ),
      TalkerDioLogger(
        talker: getIt<Talker>(),
        settings: const TalkerDioLoggerSettings(
          printResponseData: true,
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
    ]);
  }

  Future<T> _handleRequest<T>(
    Future<Response<Map<String, dynamic>>> Function() request, {
    FromJson<T>? fromJson,
  }) async {
    try {
      if (!await network.checkInternetConnection()) {
        throw const RemoteException(FailureType.connection);
      }

      final response = await request();
      final data = response.data;

      if (data == null) {
        throw const RemoteException(FailureType.emptyResponse);
      }

      if (fromJson != null) {
        return fromJson(data);
      }

      return data as T;
    } on DioException catch (e) {
      throw RemoteException.fromDioException(e);
    } on SocketException {
      throw const RemoteException(FailureType.connection);
    } on TimeoutException {
      throw const RemoteException(FailureType.timeout);
    } catch (e, s) {
      throw _unknownExc(e, s);
    }
  }

  ///  🔹 GET
  Future<T> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    FromJson<T>? fromJson,
  }) async {
    return _handleRequest(
      () =>
          dio.get<Map<String, dynamic>>(url, queryParameters: queryParameters),
      fromJson: fromJson,
    );
  }

  ///  🔹 POST
  Future<T> post<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    FromJson<T>? fromJson,
  }) async {
    return _handleRequest(
      () => dio.post<Map<String, dynamic>>(
        url,
        data: body,
        queryParameters: queryParameters,
      ),
      fromJson: fromJson,
    );
  }

  /// 🔹 PUT
  Future<T> put<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    FromJson<T>? fromJson,
  }) async {
    return _handleRequest(
      () => dio.put<Map<String, dynamic>>(
        url,
        data: body,
        queryParameters: queryParameters,
      ),
      fromJson: fromJson,
    );
  }

  /// 🔹 DELETE
  Future<T> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    FromJson<T>? fromJson,
  }) async {
    return _handleRequest(
      () => dio.delete<Map<String, dynamic>>(
        url,
        queryParameters: queryParameters,
      ),
      fromJson: fromJson,
    );
  }

  RemoteException _unknownExc(Object e, StackTrace? s) {
    return RemoteException(FailureType.unknown, error: e, stackTrace: s);
  }
}
