import 'package:app/app/router/app_routes.dart';
import 'package:app/app/router/guards/route_guard.dart';
import 'package:core/core.dart';

class AuthGuard extends RouteGuard {
  const AuthGuard();

  @override
  bool canActivate(RoleEnum userRole) {
    return userRole != RoleEnum.GUEST;
  }

  @override
  String? redirectTo(RoleEnum userRole) {
    if (!canActivate(userRole)) {
      return AppRoutes.login;
    }
    return null;
  }
}
