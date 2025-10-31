import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

@immutable
final class RemoteException implements Exception {
  const RemoteException(
    this.failureType, {
    this.error,
    this.message,
    this.stackTrace,
    this.statusCode,
  });

  factory RemoteException.fromDioException(
    DioException e, {
    void Function(DioException error)? onError,
    bool shouldLog = true,
  }) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final msg = (data['message'] ?? data['Message'] ?? data['error'])
          ?.toString();
      if (msg != null && msg.isNotEmpty) {
        return RemoteException(
          FailureType.unknown,
          message: msg,
          error: e,
          stackTrace: e.stackTrace,
        );
      }
    }
    if (e.message != null && e.message!.isNotEmpty) {
      return RemoteException(
        FailureType.unknown,
        message: e.message,
        error: e,
        stackTrace: e.stackTrace,
      );
    }

    final status = e.response?.statusCode;
    final message = _extractMessage(e);

    switch (status) {
      case 400:
        return RemoteException(
          FailureType.badRequest,
          statusCode: 400,
          message: message,
          error: e.error,
        );
      case 401:
        return RemoteException(
          FailureType.noAuthorization,
          statusCode: 401,
          message: message,
          error: e.error,
        );
      case 403:
        return RemoteException(
          FailureType.forbidden,
          statusCode: 403,
          message: message,
          error: e.error,
        );
      case 404:
        return RemoteException(
          FailureType.notFound,
          statusCode: 404,
          message: message,
          error: e.error,
        );
      case 500:
        return RemoteException(
          FailureType.internalServer,
          statusCode: 500,
          message: message,
          error: e.error,
        );
      default:
        return RemoteException(
          FailureType.unknown,
          statusCode: status,
          message: message,
          error: e.error,
        );
    }
  }

  static String? _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          e.message;
    }
    return e.message;
  }

  final dynamic error;
  final FailureType failureType;
  final StackTrace? stackTrace;
  final String? message;
  final int? statusCode;

  RemoteException copyWith({
    dynamic error,
    FailureType? failureType,
    StackTrace? stackTrace,
    String? message,
    int? statusCode,
  }) {
    return RemoteException(
      failureType ?? this.failureType,
      error: error ?? this.error,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}

/// Enum representing different failure types.
enum FailureType {
  /// HTTP 400 error.
  badRequest('Represents http error '),

  /// HTTP 401 error.
  noAuthorization('Authentication error'),

  /// HTTP 403 error.
  forbidden('Forbidden http error'),

  /// HTTP 500 error.
  internalServer('Internal server http error'),

  /// JSON decoding error.
  decode('Json decode error'),

  /// JSON deserialization error.
  deserialization('Json deserialization error'),

  /// No internet connection error.
  connection('Device unconected internet'),

  /// Unknown error.
  unknown('Unknown error'),

  /// Not found error.
  notFound('Not found error'),

  /// Time out error.
  timeout('timeout'),

  /// Empty response error.
  emptyResponse('Ответ сервера пуст');

  const FailureType(this.message);

  final String message;
}
