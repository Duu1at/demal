import 'package:app/app/router/guards/route_guard.dart';
import 'package:core/core.dart';

class GuestOnlyGuard extends RouteGuard {
  const GuestOnlyGuard();

  @override
  bool canActivate(RoleEnum userRole) {
    return userRole == RoleEnum.GUEST;
  }

  @override
  String? redirectTo(RoleEnum userRole) {
    if (!canActivate(userRole)) {
      switch (userRole) {
        case RoleEnum.CLIENT:
          return '/';
        case RoleEnum.PARTNER:
          return '/partner';
        case RoleEnum.GUEST:
          return null;
      }
    }
    return null;
  }
}
