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

  final dynamic error;
  final FailureType failureType;
  final StackTrace? stackTrace;
  final String? message;
  final int? statusCode;
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
