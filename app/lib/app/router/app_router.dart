import 'dart:async';
import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';
export 'app_routes.dart';
export 'app_router_redirect.dart';
export 'route_args.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
      (_) => notifyListeners(),
    );
  }
  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

@immutable
final class AppRouter {
  factory AppRouter.instance() => const AppRouter._();
  const AppRouter._();

  GoRouter router(AuthCubit authCubit) {
    return GoRouter(
      initialLocation: '/',
      navigatorKey: AppRoutes.navigatorKey,
      debugLogDiagnostics: kDebugMode,
      refreshListenable: GoRouterRefreshStream(authCubit.stream),
      redirect: AppRouterRedirect(authCubit).handleRedirect,
      errorBuilder: (_, _) => const ErrorView(),
      routes: [
        GoRoute(
          path: '/',
          parentNavigatorKey: AppRoutes.navigatorKey,
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
        ),
        GoRoute(
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
                  child: OtpView(extra.email),
                );
              },
            ),
          ],
        ),

        GoRoute(
          path: AppRoutes.settings,
          name: AppRoutes.settings,
          parentNavigatorKey: AppRoutes.navigatorKey,
          builder: (context, state) => const SettingsView(),
          routes: [
            GoRoute(
              path: AppRoutes.settingsAboutUs,
              name: AppRoutes.settingsAboutUs,
              builder: (context, state) => const AboutUsView(),
            ),
          ],
        ),

        GoRoute(
          path: AppRoutes.partnerVerification,
          name: AppRoutes.partnerVerification,
          parentNavigatorKey: AppRoutes.navigatorKey,
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
        ),

        GoRoute(
          path: AppRoutes.partner,
          name: AppRoutes.partner,
          parentNavigatorKey: AppRoutes.navigatorKey,
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
        ),
        GoRoute(
          path: AppRoutes.accessDenied,
          name: AppRoutes.accessDenied,
          parentNavigatorKey: AppRoutes.navigatorKey,
          builder: (context, state) => const AccessDeniedView(),
        ),
      ],
    );
  }
}
