import 'package:api_client/api_client.dart';
import 'package:app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

abstract final class Parser {
  static String get _noInternet => 'No internet connection';
  static String get _noInternetMessage => 'Check your internet connection';
  static String get _technicalError => 'Technical error, please contact support';
  static String get _somethingWentWrong => 'Something went wrong';

  static String getMessage(Object error) {
    return switch (error) {
      ApiClientException(:final dioMessage?) => dioMessage,
      ApiClientException() => _somethingWentWrong,
      ApiClientUnknownException() => _somethingWentWrong,
      ConnectionException() => _noInternet,
      ConvertException() => _technicalError,
      StorageException() => _technicalError,
      _ => _technicalError,
    };
  }

  static ErrorModel getModel(Object error) {
    return switch (error) {
      ApiClientException(:final dioMessage?) => ErrorModel(
        title: _somethingWentWrong,
        message: dioMessage,
        icon: const Icon(Icons.error),
      ),
      ApiClientException() => ErrorModel(
        title: _somethingWentWrong,
        message: _technicalError,
        icon: const Icon(Icons.error),
      ),
      ApiClientUnknownException() => ErrorModel(
        title: _somethingWentWrong,
        message: _technicalError,
        icon: const Icon(Icons.error),
      ),
      ConnectionException() => ErrorModel(
        title: _noInternet,
        message: _noInternetMessage,
        icon: const Icon(Icons.wifi_off),
      ),
      ConvertException() => ErrorModel(
        title: _somethingWentWrong,
        message: _technicalError,
        icon: const Icon(Icons.error),
      ),
      StorageException() => ErrorModel(
        title: _somethingWentWrong,
        message: _technicalError,
        icon: const Icon(Icons.error),
      ),
      _ => ErrorModel(
        title: _somethingWentWrong,
        message: _technicalError,
        icon: const Icon(Icons.error),
      ),
    };
  }
}
