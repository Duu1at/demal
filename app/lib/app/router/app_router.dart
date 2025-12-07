import 'dart:async';

import 'package:app/app/app.dart';
import 'package:app/app/router/app_router_redirect.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';

export 'app_routes.dart';
export 'route_args.dart';

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
  factory AppRouter.instance() => const AppRouter._();
  const AppRouter._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  GoRouter router(AuthCubit authCubit) {
    return GoRouter(
      initialLocation: '/',
      navigatorKey: navigatorKey,
      debugLogDiagnostics: kDebugMode,
      refreshListenable: GoRouterRefreshStream(authCubit.stream),
      redirect: AppRouterRedirect(authCubit).handleRedirect,
      routes: _buildRoutes(),
      errorBuilder: (context, state) => const ErrorView(),
    );
  }

  List<RouteBase> _buildRoutes() {
    return [
      _splashRoute(),
      _onboardingRoutes(),
      _authRoutes(),
      _settingsRoutes(),
      _clientRoutes(),
      _partnerVerificationRoute(),
      _partnerRoutes(),
    ];
  }

  GoRoute _splashRoute() {
    return GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    );
  }

  GoRoute _onboardingRoutes() {
    return GoRoute(
      path: AppRoutes.initialSettings,
      builder: (context, state) => const InitialSettingsView(),
      routes: [
        GoRoute(
          path: AppRoutes.onboardingOne,
          name: AppRoutes.onboardingOne,
          builder: (context, state) => const OnboardingOneView(),
        ),
        GoRoute(
          path: AppRoutes.onboardingTwo,
          name: AppRoutes.onboardingTwo,
          builder: (context, state) => const OnboardingTwoView(),
        ),
        GoRoute(
          path: AppRoutes.onboardingThree,
          name: AppRoutes.onboardingThree,
          builder: (context, state) => const OnboardingThreeView(),
        ),
      ],
    );
  }

  GoRoute _authRoutes() {
    return GoRoute(
      path: AppRoutes.login,
      name: AppRoutes.login,
      builder: (context, state) => const LoginView(),
      routes: [
        GoRoute(
          path: AppRoutes.otp,
          name: AppRoutes.otp,
          builder: (context, state) {
            final extra = state.extra as OtpArgs?;

            if (extra == null) return const ErrorView();

            return BlocProvider.value(
              value: extra.otpCubit,
              child: OtpView(extra.phoneNumber),
            );
          },
        ),
      ],
    );
  }

  GoRoute _settingsRoutes() {
    return GoRoute(
      path: AppRoutes.settings,
      name: AppRoutes.settings,
      parentNavigatorKey: navigatorKey,
      builder: (context, state) => const SettingsView(),
      routes: [
        GoRoute(
          path: AppRoutes.settingsAboutUs,
          name: AppRoutes.settingsAboutUs,
          builder: (context, state) => const AboutUsView(),
        ),
      ],
    );
  }

  GoRoute _clientRoutes() {
    return GoRoute(
      path: AppRoutes.client,
      name: AppRoutes.client,
      parentNavigatorKey: navigatorKey,
      builder: (context, state) => const ClientHomeView(),
      routes: [
        GoRoute(
          path: AppRoutes.clientTourDetails,
          name: AppRoutes.clientTourDetails,
          builder: (context, state) {
            final tourId = state.pathParameters['tourId'];
            if (tourId == null) return const ErrorView();
            return ClientTourDetailsView(tourId);
          },
        ),
        GoRoute(
          path: AppRoutes.clientTourTickets,
          name: AppRoutes.clientTourTickets,
          builder: (context, state) => const ClientTourTicketsView(),
        ),
        GoRoute(
          path: AppRoutes.clientTourFilters,
          name: AppRoutes.clientTourFilters,
          builder: (context, state) {
            final extra = state.extra as ToursBloc?;
            if (extra == null) return const ErrorView();
            return BlocProvider.value(
              value: extra,
              child: const ClientTourFiltersView(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.clientBookingDetails,
          name: AppRoutes.clientBookingDetails,
          builder: (context, state) => const ClientBookingDetailsView(),
        ),
        GoRoute(
          path: AppRoutes.clientBookingStatus,
          name: AppRoutes.clientBookingStatus,
          builder: (context, state) => const ClientBookingStatusView(),
        ),
      ],
    );
  }

  GoRoute _partnerVerificationRoute() {
    return GoRoute(
      path: AppRoutes.partnerVerification,
      name: AppRoutes.partnerVerification,
      parentNavigatorKey: navigatorKey,
      builder: (context, state) => const PartnerVerificationView(),
      routes: [
        GoRoute(
          path: 'status',
          name: AppRoutes.partnerVerificationStatus,
          builder: (context, state) => const PartnerVerificationStatusView(),
        ),
        GoRoute(
          path: 'rejected',
          name: AppRoutes.partnerVerificationRejected,
          builder: (context, state) => const PartnerVerificationRejectedView(),
        ),
      ],
    );
  }

  GoRoute _partnerRoutes() {
    return GoRoute(
      path: AppRoutes.partner,
      name: AppRoutes.partner,
      parentNavigatorKey: navigatorKey,
      builder: (context, state) => const PartnerHomeView(),
      routes: [
        GoRoute(
          path: AppRoutes.partnerCreateTour,
          name: AppRoutes.partnerCreateTour,
          builder: (context, state) => const CreateTourView(),
        ),
        GoRoute(
          path: AppRoutes.partnerEditTour,
          name: AppRoutes.partnerEditTour,
          builder: (context, state) {
            final tour = state.extra as TourModel?;
            if (tour == null) return const ErrorView();
            return CreateTourView(tour: tour);
          },
        ),
        GoRoute(
          path: AppRoutes.partnerToursBookings,
          name: AppRoutes.partnerToursBookings,
          builder: (context, state) {
            final tourId = state.pathParameters['tourId'];
            final tour = state.extra as TourModel?;
            if (tourId == null) return const ErrorView();
            return ToursBookingsView(tourId, tour);
          },
        ),
      ],
    );
  }
}
