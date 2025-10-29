import 'package:auth/src/enums/role_enum.dart';
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
  const AppRouter._({required this.isFirstTime, required this.role});

  factory AppRouter.instance({required bool isFirstTime, required Role role}) =>
      AppRouter._(isFirstTime: isFirstTime, role: role);

  final bool isFirstTime;
  final Role role;

  static const onboardingOne = 'onboarding-one';
  static const onboardingTwo = 'onboarding-two';
  static const onboardingThree = 'onboarding-three';
  static const login = 'login';
  static const otp = 'otp';

  /// route client
  static const client = 'client';
  static const clientSettings = 'client-settings';
  static const clientTourDetails = 'client-tour-details';
  static const clientTourTickets = 'client-tour-tickets';
  static const clientAboutUs = 'client-about-us';
  static const clientBookingDetails = 'client-booking-details';
  static const clientBookingStatus = 'client-booking-status';

  ///route partner
  static const partner = 'partner';
  static const partnerSettings = 'partner-settings';

  bool get isClient => role == Role.client;
  String get _initialRoute {
    if (isFirstTime) return '/';
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
        path: clientTourDetails,
        name: clientTourDetails,
        builder: (context, state) => const ClientTourDetailsView(),
      ),
      GoRoute(
        path: clientTourTickets,
        name: clientTourTickets,
        builder: (context, state) => const ClientTourTicketsView(),
      ),
      GoRoute(
        path: clientSettings,
        name: clientSettings,
        builder: (context, state) => const ClientSettingsView(),
      ),
      GoRoute(
        path: clientAboutUs,
        name: clientAboutUs,
        builder: (context, state) => const ClientAboutView(),
      ),
      GoRoute(
        path: clientBookingDetails,
        name: clientBookingDetails,
        builder: (context, state) => const ClientBookingDetailsView(),
      ),
      GoRoute(
        path: clientBookingStatus,
        name: clientBookingStatus,
        builder: (context, state) => const ClientBookingStatusView(),
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
