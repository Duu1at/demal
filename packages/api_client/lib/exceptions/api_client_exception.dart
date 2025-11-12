import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';

@immutable
final class ApiClientException implements Exception {
  const ApiClientException(
    this.dioError, [
    this.stackTrace,
    this.message,
  ]);

  final DioException dioError;
  final StackTrace? stackTrace;
  final String? message;

  String? get dioMessage => dioError.errorMessage;
}

@immutable
final class ApiClientUnknownException implements Exception {
  const ApiClientUnknownException(
    this.error, [
    this.stackTrace,
    this.message,
  ]);

  final Object error;
  final StackTrace? stackTrace;
  final String? message;
}
