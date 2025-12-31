import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/app/router/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRouterRedirect {
  const AppRouterRedirect(this._authCubit);
  final AuthCubit _authCubit;

  String? handleRedirect(BuildContext context, GoRouterState state) {
    final status = _authCubit.state.status;
    final isUnauthenticated = status == AuthStatus.unauthenticated;
    final path = state.uri.path;

    final isPublicRoute =
        path == '/' ||
        path.startsWith('/client/tour_details/') ||
        path.startsWith('/onboarding') ||
        path == '/settings' ||
        path == '/settings/about_us';

    final isAuthRoute = path.startsWith('/login') || path == '/otp';

    if (isUnauthenticated) {
      if (isAuthRoute || isPublicRoute) {
        return null;
      }
      return AppRoutes.login;
    }

    if (!isUnauthenticated && isAuthRoute) {
      return '/';
    }

    if (!isUnauthenticated && path.startsWith('/onboarding')) {
      return '/';
    }

    return null;
  }
}
