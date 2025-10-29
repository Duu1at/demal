import 'package:app/main.dart';
import 'package:core/either/either.dart';
import 'package:core/network/exception/remote_exception.dart';
import 'package:core/network/network_client/network_client.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

typedef FromJson<T> = T Function(Map<String, dynamic>);

typedef ResolveValue = String? Function();

class RemoteClient {
  RemoteClient({required this.dio, required this.network, this.token}) {
    initilize();
  }

  final Dio dio;

  final NetworkClient network;

  final ResolveValue? token;

  void initilize() {
    dio.interceptors.addAll([
      TalkerDioLogger(
        talker: talker,
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
          options.headers['X-App-Type'] = 'client';
          return handler.next(options);
        },
        onError: (error, handler) => handler.next(error),
        onResponse: (response, handler) => handler.next(response),
      ),
    ]);
  }

  Future<Either<T, RemoteException>> post<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (!await network.checkInternetConnection()) {
        return const Left(RemoteException(FailureType.connection));
      }

      final headers = <String, dynamic>{};
      final resolvedToken = token?.call();
      if (resolvedToken != null) {
        headers['Authorization'] = 'Bearer $resolvedToken';
      }

      final response = await dio.post<Map<String, dynamic>>(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      final responseData = response.data;
      if (responseData == null) {
        throw Exception('Ответ сервера пуст.');
      }

      return Right(true as T);
    } on DioException catch (e) {
      return Left(_parseDioException(e));
    } catch (e, s) {
      return Left(_unknownExc(e, s));
    }
  }

  RemoteException _unknownExc(Object e, StackTrace? s) {
    return RemoteException(FailureType.unknown, error: e, stackTrace: s);
  }

  RemoteException _parseDioException(DioException exception) {
    return switch (exception.response?.statusCode) {
      400 => RemoteException(
        FailureType.badRequest,
        statusCode: 400,
        message: exception.message,
        error: exception.error,
      ),
      401 => RemoteException(
        FailureType.noAuthorization,
        message: exception.message,
        statusCode: 401,
        error: exception.error,
      ),
      403 => RemoteException(
        FailureType.forbidden,
        message: exception.message,
        statusCode: 403,
        error: exception.error,
      ),
      500 => RemoteException(
        FailureType.internalServer,
        message: exception.message,
        statusCode: 500,
        error: exception.error,
      ),
      _ => RemoteException(
        FailureType.unknown,
        message: exception.message,
        statusCode: exception.response?.statusCode,
        error: exception.error,
      ),
    };
  }
}
