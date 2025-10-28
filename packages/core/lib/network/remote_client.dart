import 'package:core/either/either.dart';
import 'package:core/network/exception/remote_exception.dart';
import 'package:core/network/network_client/network_client.dart';
import 'package:dio/dio.dart';

part 'remote_client_base_extension.dart';

/// {@template mq_remote_client}
/// MQ remote client package
/// {@endtemplate}
typedef FromJson<T> = T Function(Map<String, dynamic>);

/// A function type that converts a [Map<String, dynamic>] to an object of type T
///
/// Used to deserialize JSON responses from the server.
typedef ResolveValue = String? Function();

/// A client for making HTTP requests with custom headers and handling JSON
/// responses.
class RemoteClient {
  /// {@macro mq_remote_client}
  const RemoteClient({required this.dio, required this.network, this.token});

  /// The Dio instance used for making HTTP requests.
  final Dio dio;

  /// The network client for handling network-related tasks.
  final NetworkClient network;

  /// A function that resolves the language value for the headers.

  /// A function that resolves the authorization token for the headers.
  final ResolveValue? token;

  /// A function that resolves the old token for the headers.

  /// Initializes the Dio instance with interceptors to add custom headers.
  void initilize() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers = {
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
            'X-App-Type': 'client',
          };
          return handler.next(options);
        },
      ),
    );
  }

  /// Makes a GET request to the given [url] and parses the response as type [T]
  Future<Either<T, RemoteException>> get<T>(String url) {
    return _get<T>(url);
  }

  /// Makes a POST request to the given [url] with an optional [body] and parses
  /// the response as type [T].
  Future<Either<T, RemoteException>> post<T>(
    String url, {
    Map<String, dynamic>? body,
  }) {
    return _post<T>(url, body: body);
  }

  Future<Either<T, RemoteException>> _post<T>(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      // 1. Проверяем токен, если он есть
      final headers = <String, dynamic>{};
      final resolvedToken = token?.call();
      if (resolvedToken != null) {
        headers['Authorization'] = 'Bearer $resolvedToken';
      }

      final response = await dio.post<Map<String, dynamic>>(
        url,
        data: body,
        options: Options(headers: headers),
      );

      final responseData = response.data;
      if (responseData == null) {
        throw Exception('Ответ сервера пуст.');
      }

      return Right(true as T);
    } on DioException catch (e) {
      // 5. Ловим ошибку Dio (включая твою 400 Bad Request)
      return Left(RemoteException(FailureType.deserialization, message: '$e'));
    } catch (e) {
      // 6. Ловим другие неизвестные ошибки
      return Left(RemoteException(FailureType.deserialization, message: '$e'));
    }
  }
}
