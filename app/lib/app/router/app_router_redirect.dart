import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/app/router/app_routes.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRouterRedirect {
  const AppRouterRedirect(this._authCubit);
  final AuthCubit _authCubit;

  String? handleRedirect(BuildContext context, GoRouterState state) {
    final userRole = _authCubit.state.user?.role;
    final path = state.uri.path;

    final routeMetadata = AppRoutes.getMetadata(path);

    final guard = routeMetadata.getGuard();

    final redirect = guard.redirectTo(userRole ?? RoleEnum.GUEST);

    debugPrint('Router: Path: $path, Role: $userRole, Redirect: $redirect');

    return redirect;
  }
}
