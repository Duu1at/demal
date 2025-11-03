import 'package:meta/meta.dart';

@immutable
final class AuthException implements Exception {
  const AuthException([this.error, this.stackTrace]);

  final dynamic error;

  final StackTrace? stackTrace;
}
