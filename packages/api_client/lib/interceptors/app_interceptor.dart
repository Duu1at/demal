import 'package:api_client/api_client.dart';

class AppInterceptor extends Interceptor {
  const AppInterceptor({
    this.token,
    this.role,
  });

  final ResolveValue? token;
  final ResolveValue? role;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final tokenValue = token?.call();
    final roleValue = role?.call();

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
      if (roleValue != null && roleValue.isNotEmpty) 'x-app-role': roleValue,
    });
    return handler.next(options);
  }
}
