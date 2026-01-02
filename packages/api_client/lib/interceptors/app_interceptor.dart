import 'package:api_client/api_client.dart';

class AppInterceptor extends Interceptor {
  const AppInterceptor({this.token});

  final ResolveValue? token;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final tokenValue = token?.call();

    if (options.data is FormData) {
      options.headers.remove('Content-Type');
      if (options.contentType != null) {
        options.contentType = null;
      }
    } else if (!options.headers.containsKey('Content-Type') && options.contentType == null) {
      options.headers['Content-Type'] = 'application/json; charset=utf-8';
    }

    options.headers.addAll({
      if (tokenValue != null && tokenValue.isNotEmpty) 'Authorization': 'Bearer $tokenValue',
    });
    return handler.next(options);
  }
}
