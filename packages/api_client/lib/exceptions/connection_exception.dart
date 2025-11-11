import 'package:meta/meta.dart';

@immutable
final class ConnectionException implements Exception {
  const ConnectionException([
    this.error,
    this.stackTrace,
    this.message,
  ]);

  final Object? error;
  final StackTrace? stackTrace;
  final String? message;
}
