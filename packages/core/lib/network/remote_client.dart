import 'dart:async';
import 'dart:io';
import 'package:core/di/injector.dart';
import 'package:core/either/either.dart';
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
      TalkerDioLogger(
        talker: getIt<Talker>(),
        settings: const TalkerDioLoggerSettings(
          printResponseData: true,
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Content-Type'] = 'application/json; charset=utf-8';
          options.headers['Accept'] = 'application/json';

          final appRole = resolveAppRole?.call();
          if (appRole != null) {
            options.headers['X-App-Role'] = appRole;
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
    ]);
  }

  Future<Either<T, RemoteException>> _handleRequest<T>(
    Future<Response<Map<String, dynamic>>> Function() request, {
    FromJson<T>? fromJson,
  }) async {
    try {
      if (!await network.checkInternetConnection()) {
        return const Left(RemoteException(FailureType.connection));
      }

      final response = await request();

      final data = response.data;
      if (data == null) {
        return const Left(RemoteException(FailureType.emptyResponse));
      }

      if (fromJson != null) {
        return Right(fromJson(data));
      }

      return Right(data as T);
    } on DioException catch (e) {
      return Left(_parseDioException(e));
    } on SocketException {
      return const Left(RemoteException(FailureType.connection));
    } on TimeoutException {
      return const Left(RemoteException(FailureType.timeout));
    } catch (e, s) {
      return Left(_unknownExc(e, s));
    }
  }

  ///  🔹 GET
  Future<Either<T, RemoteException>> get<T>(
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
  Future<Either<T, RemoteException>> post<T>(
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
  Future<Either<T, RemoteException>> put<T>(
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
  Future<Either<T, RemoteException>> delete<T>(
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

  RemoteException _parseDioException(DioException e) {
    final status = e.response?.statusCode;
    final message = _extractMessage(e);

    return switch (status) {
      400 => RemoteException(
        FailureType.badRequest,
        statusCode: 400,
        message: message,
        error: e.error,
      ),
      401 => RemoteException(
        FailureType.noAuthorization,
        statusCode: 401,
        message: message,
        error: e.error,
      ),
      403 => RemoteException(
        FailureType.forbidden,
        statusCode: 403,
        message: message,
        error: e.error,
      ),
      404 => RemoteException(
        FailureType.notFound,
        statusCode: 404,
        message: message,
        error: e.error,
      ),
      500 => RemoteException(
        FailureType.internalServer,
        statusCode: 500,
        message: message,
        error: e.error,
      ),
      _ => RemoteException(
        FailureType.unknown,
        statusCode: status,
        message: message,
        error: e.error,
      ),
    };
  }

  String? _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          e.message;
    }
    return e.message;
  }

  RemoteException _unknownExc(Object e, StackTrace? s) {
    return RemoteException(FailureType.unknown, error: e, stackTrace: s);
  }
}
