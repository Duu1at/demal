import 'dart:io';

import 'package:core/core.dart';
import 'package:dio/dio.dart';

const String baseErrorMessage = 'ERROR';

extension ObjectX on Object? {
  String parseError({String? defaultMessage}) {
    // getIt<Talker>().log('parseError called for $runtimeType: $this');
    if (this == null) return defaultMessage ?? baseErrorMessage;

    if (this is RemoteException) {
      return (this! as RemoteException).message ?? defaultMessage ?? baseErrorMessage;
    }

    if (this is DioException) {
      return (this! as DioException).message ?? defaultMessage ?? baseErrorMessage;
    }

    if (this is Exception) return toString();

    if (this is SocketException) return (this! as SocketException).message;

    return defaultMessage ?? baseErrorMessage;
  }
}
