import 'package:app/app/app.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRouterRedirect {
  const AppRouterRedirect(this._authCubit);

  final AuthCubit _authCubit;

  String? handleRedirect(BuildContext context, GoRouterState state) {
    final authState = _authCubit.state;

    if (authState.status == AuthStatus.initial || authState.status == AuthStatus.loading) {
      return null;
    }

    final role = authState.user?.role ?? RoleEnum.GUEST;

    final metadata = AppRouteMetadataResolver.resolve(state);
    final guard = metadata.getGuard();

    final redirect = guard.redirectTo(role);

    if (redirect == null || redirect == state.uri.path) {
      return null;
    }

    return redirect;
  }
}
