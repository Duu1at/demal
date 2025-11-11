import 'package:api_client/api_client.dart';

class BaseInterceptor extends Interceptor {
  const BaseInterceptor({
    this.role,
    this.token,
  });

  final ResolveValue? role;
  final ResolveValue? token;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final tokenValue = token?.call();
    final roleValue = role?.call();
    options.headers.addAll({
      if (tokenValue != null && tokenValue.isNotEmpty) 'Authorization': 'Bearer $tokenValue',
      if (roleValue != null && roleValue.isNotEmpty) 'X-App-Role': roleValue,
    });
    return handler.next(options);
  }
}
