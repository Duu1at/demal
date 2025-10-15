import 'package:app/app/cubits/app_cubit.dart' show Role;
import 'package:app/client/client.dart';
import 'package:app/login/view/login_view.dart';
import 'package:app/login/view/otp_view.dart';
import 'package:app/partner/partner.dart';
import 'package:app/welcome/welcome.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final clientNavigatorKey = GlobalKey<NavigatorState>();
final partnerNavigatorKey = GlobalKey<NavigatorState>();

@immutable
final class AppRouter {
  const AppRouter._({required this.isNewUser, required this.role});

  factory AppRouter.instance({required bool isNewUser, required Role role}) =>
      AppRouter._(isNewUser: isNewUser, role: role);

  final bool isNewUser;
  final Role role;

  static const onboardingOne = 'onboarding-one';
  static const onboardingTwo = 'onboarding-two';
  static const onboardingThree = 'onboarding-three';
  static const login = 'login';
  static const otp = 'otp';

  /// route client
  static const client = 'client';
  static const clientSettings = 'client-settings';

  ///route partner
  static const partner = 'partner';
  static const partnerSettings = 'partner-settings';

  bool get isClient => role == Role.client;
  String get _initialRoute {
    if (isNewUser) return '/';
    return isClient ? '/$client' : '/$partner';
  }

  GoRouter router() {
    return GoRouter(
      initialLocation: _initialRoute,
      navigatorKey: navigatorKey,
      debugLogDiagnostics: kDebugMode,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const InitialSettingsView(),
          routes: [
            GoRoute(
              path: onboardingOne,
              name: onboardingOne,
              builder: (context, state) => const OnboardingOneView(),
            ),
            GoRoute(
              path: onboardingTwo,
              name: onboardingTwo,
              builder: (context, state) => const OnboardingTwoView(),
            ),
            GoRoute(
              path: onboardingThree,
              name: onboardingThree,
              builder: (context, state) => const OnboardingThreeView(),
            ),
          ],
        ),
        GoRoute(
          path: '/$login',
          name: login,
          builder: (context, state) => const LoginView(),
          routes: [
            GoRoute(
              path: otp,
              name: otp,
              builder: (context, state) {
                final phone = state.extra as String;
                return OtpView(phone);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/$client',
          name: client,
          parentNavigatorKey: navigatorKey,
          builder: (context, state) => const ClientHomeView(),
          routes: _clientRoutes,
        ),
        GoRoute(
          path: '/$partner',
          name: partner,
          parentNavigatorKey: navigatorKey,
          builder: (context, state) => const PartnerHomeView(),
          routes: _partnerRoutes,
        ),
      ],
    );
  }

  static List<RouteBase> get _clientRoutes {
    return [
      GoRoute(
        path: clientSettings,
        name: clientSettings,
        builder: (context, state) => const ClientSettingsView(),
      ),
    ];
  }

  static List<RouteBase> get _partnerRoutes {
    return [
      GoRoute(
        path: partnerSettings,
        name: partnerSettings,
        builder: (context, state) => const PartnerSettingsView(),
      ),
    ];
  }
}
