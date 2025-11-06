import 'package:api_client/src/src.dart';
import 'package:dio/dio.dart';

class BearerApiClient extends ApiClient {
  BearerApiClient({
    required super.connection,
    required super.dio,
    required this.getAccessToken,
    required this.getRefreshToken,
    this.language,
    this.platform,
    this.buildNumber,
  }) {
    _initialize();
  }

  final ResolveValue? language;
  final ResolveValue? buildNumber;
  final ResolveValue? platform;
  final ResolveValue getAccessToken;
  final ResolveValue getRefreshToken;

  void _initialize() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final accessToken = getAccessToken.call();
          final languageValue = language?.call();
          final buildNumberValue = buildNumber?.call();
          final platformValue = platform?.call();
          options.headers.addAll({
            if (accessToken != null && accessToken.isNotEmpty) 'Authorization': 'Bearer $accessToken',
            if (languageValue != null && languageValue.isNotEmpty) 'Accept-Language': languageValue,
            if (buildNumberValue != null && buildNumberValue.isNotEmpty) 'versionBuild': buildNumberValue,
            if (platformValue != null && platformValue.isNotEmpty) 'os': platformValue,
          });
          return handler.next(options);
        },
      ),
    );
  }
}
