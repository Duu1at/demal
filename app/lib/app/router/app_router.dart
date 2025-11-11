import 'dart:async';
import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/app/view/splash_view.dart';
import 'package:app/client/client.dart';
import 'package:app/login/view/login_view.dart';
import 'package:app/login/view/otp_view.dart';
import 'package:app/partner/partner.dart';
import 'package:app/welcome/welcome.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final clientNavigatorKey = GlobalKey<NavigatorState>();
final partnerNavigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}

@immutable
final class AppRouter {
  const AppRouter._();
  factory AppRouter.instance() => const AppRouter._();

  /// onboarding
  static const initialSettings = 'initial-settings';
  static const onboardingOne = 'onboarding-one';
  static const onboardingTwo = 'onboarding-two';
  static const onboardingThree = 'onboarding-three';

  ///login
  static const login = 'login';
  static const otp = 'otp';

  /// client
  static const client = 'client';
  static const clientSettings = 'client-settings';
  static const clientTourDetails = 'client-tour-details';
  static const clientTourTickets = 'client-tour-tickets';
  static const clientTourFilters = 'client-tour-filters';
  static const clientAboutUs = 'client-about-us';
  static const clientBookingDetails = 'client-booking-details';
  static const clientBookingStatus = 'client-booking-status';

  /// partner
  static const partner = 'partner';
  static const partnerSettings = 'partner-settings';

  GoRouter router(AuthCubit authCubit) {
    return GoRouter(
      initialLocation: '/',
      navigatorKey: navigatorKey,
      debugLogDiagnostics: kDebugMode,
      refreshListenable: GoRouterRefreshStream(authCubit.stream),
      redirect: (context, state) {
        final authState = authCubit.state;
        final path = state.uri.path;

        final onboardingComplete = authState.hasCompletedOnboarding;

        switch (authState.status) {
          case AuthStatus.initial:
          case AuthStatus.failure:
            return '/';

          case AuthStatus.authenticated:
            final role = authState.user?.role;

            if (role == Role.client) {
              if (path.startsWith('/$client')) return null;
              return '/$client';
            }
            if (role == Role.partner) {
              if (path.startsWith('/$partner')) return null;
              return '/$partner';
            }
            return '/$initialSettings';

          case AuthStatus.unauthenticated:
            final isGoingToOnboarding = path.startsWith('/$initialSettings');
            final isGoingToLogin = path.startsWith('/$login');

            if (!onboardingComplete) {
              if (isGoingToOnboarding) return null;
              return '/$initialSettings';
            } else {
              if (isGoingToLogin) return null;

              return '/$login';
            }
        }
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SplashView()),

        GoRoute(
          path: '/$initialSettings',
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
              builder: (context, state) => OtpView(state.extra! as String),
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
        path: clientTourFilters,
        name: clientTourFilters,
        builder: (context, state) {
          return BlocProvider.value(
            value: state.extra! as ToursBloc,
            child: const ClientTourFiltersView(),
          );
        },
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
