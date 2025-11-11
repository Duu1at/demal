import 'package:meta/meta.dart';

@immutable
final class ConvertException implements Exception {
  const ConvertException([
    this.error,
    this.stackTrace,
    this.message,
  ]);

  final Object? error;
  final StackTrace? stackTrace;
  final String? message;
}
