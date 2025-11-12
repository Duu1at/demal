import 'package:meta/meta.dart';

@immutable
final class TourException implements Exception {
  const TourException([this.error, this.stackTrace]);

  final dynamic error;

  final StackTrace? stackTrace;
}
