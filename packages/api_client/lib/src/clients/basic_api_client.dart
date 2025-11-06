import 'dart:convert';

import 'package:api_client/src/src.dart';
import 'package:dio/dio.dart';

class BasicApiClient extends ApiClient {
  BasicApiClient({
    required super.connection,
    required super.dio,
    required this.userName,
    required this.passWord,
    this.language,
    this.buildNumber,
    this.platform,
  }) {
    _initialize();
  }

  final ResolveValue userName;
  final ResolveValue passWord;
  final ResolveValue? language;
  final ResolveValue? buildNumber;
  final ResolveValue? platform;

  void _initialize() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final userNameValue = userName.call() ?? 'user';
          final passWordValue = passWord.call() ?? 'user';
          final languageValue = language?.call();
          final buildNumberValue = buildNumber?.call();
          final platformValue = platform?.call();
          options.headers.addAll({
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
            'Authorization': 'Basic ${base64Encode(utf8.encode('$userNameValue:$passWordValue'))}',
            'Accept-Language': ?languageValue,
            'versionBuild': ?buildNumberValue,
            'os': ?platformValue,
          });
          return handler.next(options);
        },
      ),
    );
  }
}
