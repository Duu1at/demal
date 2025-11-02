import 'package:meta/meta.dart';

@immutable
final class ClientTourException implements Exception {
  const ClientTourException([this.error, this.stackTrace]);

  final dynamic error;

  final StackTrace? stackTrace;
}
