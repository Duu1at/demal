import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/app/router/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRouterRedirect {
  const AppRouterRedirect(this._authCubit);

  // ignore: unused_field
  final AuthCubit _authCubit;

  String? handleRedirect(BuildContext context, GoRouterState state) {
    // Bypass auth, go straight to home page (client view)
    final path = state.uri.path;
    if (path == '/') {
      return AppRoutes.client;
    }

    return null;
  }
}
