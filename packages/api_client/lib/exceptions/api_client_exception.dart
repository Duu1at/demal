import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

@immutable
final class ApiClientException implements Exception {
  const ApiClientException(
    this.error, [
    this.stackTrace,
    this.message,
  ]);

  final DioException error;
  final StackTrace? stackTrace;
  final String? message;
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
