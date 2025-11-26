import 'package:api_client/api_client.dart';

class AppInterceptor extends Interceptor {
  const AppInterceptor({
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

    // Обработка Content-Type
    if (options.data is FormData) {
      // Для FormData удаляем Content-Type, чтобы Dio установил multipart/form-data
      options.headers.remove('Content-Type');
      if (options.contentType != null) {
        options.contentType = null;
      }
    } else if (!options.headers.containsKey('Content-Type') && options.contentType == null) {
      options.headers['Content-Type'] = 'application/json; charset=utf-8';
    }

    // Для GET запросов не устанавливаем Content-Type (они не имеют тела)

    options.headers.addAll({
      if (tokenValue != null && tokenValue.isNotEmpty) 'Authorization': 'Bearer $tokenValue',
      if (roleValue != null && roleValue.isNotEmpty) 'x-app-role': roleValue,
    });
    return handler.next(options);
  }
}
