import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/app/router/app_routes.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';

class AppRouterRedirect {
  const AppRouterRedirect(this._authCubit);

  final AuthCubit _authCubit;

  String? handleRedirect(BuildContext context, GoRouterState state) {
    final authState = _authCubit.state;
    final path = state.uri.path;
    final onboardingComplete = authState.hasCompletedOnboarding;

    switch (authState.status) {
      case AuthStatus.initial:
      case AuthStatus.failure:
        return '/';

      case AuthStatus.authenticated:
        return _handleAuthenticatedRedirect(path, authState.user?.role);

      case AuthStatus.unauthenticated:
        return _handleUnauthenticatedRedirect(path, onboardingComplete);
    }
  }

  String? _handleAuthenticatedRedirect(
    String path,
    RoleEnum? role,
  ) {
    final isGlobalRoute = path.startsWith(AppRoutes.settings);
    if (isGlobalRoute) return null;

    switch (role) {
      case RoleEnum.CLIENT:
        if (path.startsWith(AppRoutes.client)) return null;
        return AppRoutes.client;

      case RoleEnum.PARTNER:
        return _handlePartnerRedirect(path);

      case RoleEnum.ADMIN:
      case RoleEnum.UNKNOWN:
      case null:
        return AppRoutes.initialSettings;
    }
  }

  String? _handlePartnerRedirect(String path) {
    final user = _authCubit.state.user;
    final verificationStatus = user?.partnerProfile?.verificationStatus;

    if (path.startsWith(AppRoutes.partnerVerification) ||
        path.startsWith(AppRoutes.partnerVerificationStatus) ||
        path.startsWith(AppRoutes.partnerVerificationRejected)) {
      return null;
    }

    if (verificationStatus == null) {
      return AppRoutes.partnerVerification;
    }

    switch (verificationStatus) {
      case PartnerVerifyStatusEnum.pending:
        return AppRoutes.partnerVerificationStatus;

      case PartnerVerifyStatusEnum.rejected:
        return AppRoutes.partnerVerificationRejected;

      case PartnerVerifyStatusEnum.verified:
        if (path.startsWith(AppRoutes.partner)) return null;
        return AppRoutes.partner;
    }
  }

  String? _handleUnauthenticatedRedirect(
    String path,
    bool onboardingComplete,
  ) {
    if (!onboardingComplete) {
      if (path.startsWith(AppRoutes.initialSettings)) return null;
      return AppRoutes.initialSettings;
    }

    if (path.startsWith(AppRoutes.login)) return null;
    return AppRoutes.login;
  }
}
