
import 'package:app/app/app.dart';
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
      return AppRouteNames.login;
    }
    return null;
  }
}
