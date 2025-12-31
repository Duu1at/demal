import 'package:app/app/router/guards/route_guard.dart';
import 'package:core/core.dart';

class NoGuard extends RouteGuard {
  const NoGuard();

  @override
  bool canActivate(RoleEnum userRole) => true;

  @override
  String? redirectTo(RoleEnum userRole) => null;
}
