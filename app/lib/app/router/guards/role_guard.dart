import 'package:app/app/app.dart';
import 'package:core/core.dart';

class RoleGuard extends RouteGuard {
  const RoleGuard({
    required this.allowedRoles,
    this.redirectPath = '/${AppRouteNames.accessDenied}',
  });

  final List<RoleEnum> allowedRoles;
  final String redirectPath;

  @override
  bool canActivate(RoleEnum userRole) {
    return allowedRoles.contains(userRole);
  }

  @override
  String? redirectTo(RoleEnum userRole) {
    if (!canActivate(userRole)) {
      if (userRole == RoleEnum.GUEST) {
        return AppRouteNames.login;
      }
      return redirectPath;
    }
    return null;
  }
}

class ClientOnlyGuard extends RoleGuard {
  const ClientOnlyGuard() : super(allowedRoles: const [RoleEnum.CLIENT]);
}

class PartnerOnlyGuard extends RoleGuard {
  const PartnerOnlyGuard() : super(allowedRoles: const [RoleEnum.PARTNER]);
}
