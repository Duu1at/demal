import 'package:core/core.dart';

abstract class RouteGuard {
  const RouteGuard();
  bool canActivate(RoleEnum userRole);
  String? redirectTo(RoleEnum userRole);
}
