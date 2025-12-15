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
        if (path == '/') return null;
        return '/';

      case AuthStatus.failure:
        if (path == '/') return null;
        return '/';

      case AuthStatus.authenticated:
        if (path == '/') {
          return _getInitialRouteForUser(authState.user?.role);
        }
        return _handleAuthenticatedRedirect(path, authState.user?.role);

      case AuthStatus.unauthenticated:
        if (path == '/') {
          return onboardingComplete ? AppRoutes.login : AppRoutes.initialSettings;
        }
        return _handleUnauthenticatedRedirect(path, onboardingComplete);
    }
  }

  String _getInitialRouteForUser(RoleEnum? role) {
    switch (role) {
      case RoleEnum.CLIENT:
        return AppRoutes.client;
      case RoleEnum.PARTNER:
        return AppRoutes.partnerVerification;
      case RoleEnum.ADMIN:
      case RoleEnum.UNKNOWN:
      case null:
        return AppRoutes.initialSettings;
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

    if (path.startsWith(AppRoutes.partnerVerification)) {
      return null;
    }

    if (verificationStatus == null) {
      return AppRoutes.partnerVerification;
    }

    switch (verificationStatus) {
      case PartnerVerifyStatusEnum.notStarted:
        return AppRoutes.partnerVerification;

      case PartnerVerifyStatusEnum.pending:
        return AppRoutes.partnerVerificationStatus;

      case PartnerVerifyStatusEnum.rejected:
        return AppRoutes.partnerVerificationRejected;

      case PartnerVerifyStatusEnum.verified:
        if (path == AppRoutes.partnerVerification ||
            path == AppRoutes.partnerVerificationStatus ||
            path == AppRoutes.partnerVerificationRejected) {
          return AppRoutes.partner;
        }

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
