import 'dart:developer';
import 'package:api_client/api_client.dart';

Type _getType<T>() => T;
final Type _voidType = _getType<void>();

typedef FromJson<T> = T Function(Map<String, dynamic>);
typedef ResolveValue = String? Function();

class ApiClient {
  const ApiClient({
    required this.dio,
    required this.connection,
  });

  final Dio dio;
  final ConnectionService connection;

  Future<Response<T>> request<T>(
    String url, {
    required RequestType method,
    Object? data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      if (await connection.checkInternetConnection()) {
        return dio.request<T>(
          url,
          data: data,
          queryParameters: queryParameters,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          options: (options ?? Options()).copyWith(method: method.value),
        );
      } else {
        log('ApiClient connection error ${method.value} $url');
        throw Exception('Connection error');
      }
    } on DioException catch (e, s) {
      throw Exception('Dio exception: $e, stackTrace: $s');
    } catch (e, s) {
      throw Exception('Unknown exception: $e, stackTrace: $s');
    }
  }

  Future<T> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await request<T>(
      path,
      method: RequestType.get,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    if (T == _voidType) return response as T;
    return response.data!;
  }

  Future<T> getType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await get<Map<String, dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return _convertType<T>(res, fromJson);
  }

  Future<List<T>> getListOfType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await get<List<dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return _convertListOfType(res, fromJson);
  }

  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await request<T>(
      path,
      method: RequestType.post,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    if (T == _voidType) return response as T;
    return response.data!;
  }

  Future<T> postType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await post<Map<String, dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _convertType<T>(res, fromJson);
  }

  Future<List<T>> postListOfType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await post<List<dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _convertListOfType(res, fromJson);
  }

  Future<T> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await request<T>(
      path,
      method: RequestType.put,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    if (T == _voidType) return response as T;
    return response.data!;
  }

  Future<T> putType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await put<Map<String, dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _convertType<T>(res, fromJson);
  }

  Future<List<T>> putListOfType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await put<List<dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _convertListOfType(res, fromJson);
  }

  Future<T> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await request<T>(
      path,
      method: RequestType.patch,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    if (T == _voidType) return response as T;
    return response.data!;
  }

  Future<T> patchType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await patch<Map<String, dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _convertType<T>(res, fromJson);
  }

  Future<List<T>> patchListOfType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await patch<List<dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _convertListOfType(res, fromJson);
  }

  Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await request<T>(
      path,
      method: RequestType.delete,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    if (T == _voidType) return response as T;
    return response.data!;
  }

  Future<T> deleteType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final res = await delete<Map<String, dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return _convertType<T>(res, fromJson);
  }

  Future<List<T>> deleteListOfType<T>(
    String path, {
    required FromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final res = await delete<List<dynamic>>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return _convertListOfType(res, fromJson);
  }

  T _convertType<T>(
    Map<String, dynamic> jsonData,
    FromJson<T> fromJson,
  ) {
    try {
      return fromJson(jsonData);
    } catch (e, s) {
      log('Type conversion error', error: e, stackTrace: s);
      throw ConvertException(e, s, 'Failed to convert to $T');
    }
  }

  List<T> _convertListOfType<T>(
    List<dynamic> jsonData,
    FromJson<T> fromJson,
  ) {
    try {
      return jsonData.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, s) {
      log('List conversion error', error: e, stackTrace: s);
      throw ConvertException(e, s, 'Failed to convert to List<$T>');
    }
  }
}
