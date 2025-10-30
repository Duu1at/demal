import 'package:core/core.dart';
import 'package:dio/dio.dart';

extension ExceptionX on Exception {
  RemoteException toRemoteException({String? message, StackTrace? stackTrace}) {
    if (this is RemoteException) {
      final e = this as RemoteException;
      return e.copyWith(
        message: message ?? e.message,
        stackTrace: stackTrace ?? e.stackTrace,
      );
    }

    if (this is DioException) {
      final e = (this as DioException).toRemoteException();
      return e.copyWith(
        message: message ?? e.message,
        stackTrace: stackTrace ?? e.stackTrace,
      );
    }

    return RemoteException(
      FailureType.unknown,
      error: this,
      message: message ?? 'Error',
      stackTrace: stackTrace,
    );
  }

  String? get userMessage {
    if (this is RemoteException) {
      return (this as RemoteException).message;
    }

    if (this is DioException) {
      return (this as DioException).message;
    }

    return 'Error';
  }
}
