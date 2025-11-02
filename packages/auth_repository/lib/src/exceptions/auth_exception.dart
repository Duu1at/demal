import 'package:meta/meta.dart';

@immutable
final class AuthException implements Exception {
  const AuthException({this.message});

  final String? message;
}
