import 'package:app/app/app.dart';
import 'package:core/core.dart';

class RouteMetadata {
  const RouteMetadata({
    this.guard,
    this.allowedRoles = const [],
    this.requiresAuth = false,
    this.isPublic = false,
  });

  final RouteGuard? guard;
  final List<RoleEnum> allowedRoles;
  final bool requiresAuth;
  final bool isPublic;

  static const public = RouteMetadata(guard: NoGuard(), isPublic: true);

  static const authenticated = RouteMetadata(guard: AuthGuard(), requiresAuth: true);

  static const guestOnly = RouteMetadata(guard: GuestOnlyGuard());

  static const clientOnly = RouteMetadata(
    guard: ClientOnlyGuard(),
    allowedRoles: [RoleEnum.CLIENT],
    requiresAuth: true,
  );

  static const partnerOnly = RouteMetadata(
    guard: PartnerOnlyGuard(),
    allowedRoles: [RoleEnum.PARTNER],
    requiresAuth: true,
  );

  RouteGuard getGuard() {
    if (guard != null) return guard!;
    if (isPublic) return const NoGuard();
    if (allowedRoles.isNotEmpty) return RoleGuard(allowedRoles: allowedRoles);
    if (requiresAuth) return const AuthGuard();
    return const NoGuard();
  }
}
