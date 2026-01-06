import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';

@immutable
final class AppRouter {
  factory AppRouter.instance() => const AppRouter._();
  const AppRouter._();

  GoRouter router() {
    return GoRouter(
      initialLocation: '/',
      navigatorKey: AppRouteNames.navigatorKey,
      debugLogDiagnostics: kDebugMode,
      errorBuilder: (_, _) => const ErrorView(),
      routes: [
        GoRoute(
          path: AppRouteNames.clientHome,
          name: AppRouteNames.clientHome,
          builder: (_, _) => const ClientToursView(),
          routes: [
            GoRoute(
              path: '${AppRouteNames.clientTourDetails}/:tourId',
              name: AppRouteNames.clientTourDetails,
              builder: (context, state) {
                final tourId = state.pathParameters['tourId'];
                if (tourId == null) return const ErrorView();
                return ClientTourDetailsView(tourId);
              },
            ),
            GoRoute(
              path: AppRouteNames.clientTourTickets,
              name: AppRouteNames.clientTourTickets,
              builder: (_, _) => const ClientMyTicketsView(),
            ),
            GoRoute(
              path: AppRouteNames.clientTourFilters,
              name: AppRouteNames.clientTourFilters,
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
              path: AppRouteNames.clientBookingDetails,
              name: AppRouteNames.clientBookingDetails,
              builder: (context, state) => const ClientBookingDetailsView(),
            ),
            GoRoute(
              path: AppRouteNames.clientBookingStatus,
              name: AppRouteNames.clientBookingStatus,
              builder: (context, state) => const ClientBookingStatusView(),
            ),
          ],
        ),
        GoRoute(
          path: '/${AppRouteNames.login}',
          name: AppRouteNames.login,
          builder: (context, state) => const LoginView(),
          routes: [
            GoRoute(
              path: AppRouteNames.otp,
              name: AppRouteNames.otp,
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
          path: '/${AppRouteNames.settings}',
          name: AppRouteNames.settings,
          parentNavigatorKey: AppRouteNames.navigatorKey,
          builder: (context, state) => const SettingsView(),
          routes: [
            GoRoute(
              path: AppRouteNames.settingsAboutUs,
              name: AppRouteNames.settingsAboutUs,
              builder: (context, state) => const AboutUsView(),
            ),
            GoRoute(
              path: AppRouteNames.settingsEditProfile,
              name: AppRouteNames.settingsEditProfile,
              builder: (context, state) => const EditProfileView(),
            ),
          ],
        ),
        
        GoRoute(
          path: '/${AppRouteNames.partnerVerification}',
          name: AppRouteNames.partnerVerification,
          parentNavigatorKey: AppRouteNames.navigatorKey,
          builder: (context, state) => const PartnerVerificationView(),
          routes: [
            GoRoute(
              path: AppRouteNames.partnerVerificationStatus,
              name: AppRouteNames.partnerVerificationStatus,
              builder: (context, state) => const PartnerVerificationStatusView(),
            ),
          ],
        ),

        GoRoute(
          path: '/${AppRouteNames.partner}',
          name: AppRouteNames.partner,
          parentNavigatorKey: AppRouteNames.navigatorKey,
          builder: (context, state) => const PartnerHomeView(),
          routes: [
            GoRoute(
              path: AppRouteNames.partnerCreateTour,
              name: AppRouteNames.partnerCreateTour,
              builder: (context, state) => const CreateTourView(),
            ),
            GoRoute(
              path: AppRouteNames.partnerEditTour,
              name: AppRouteNames.partnerEditTour,
              builder: (context, state) {
                final tour = state.extra as TourModel?;
                if (tour == null) return const ErrorView();
                return CreateTourView(tour: tour);
              },
            ),
            GoRoute(
              path: AppRouteNames.partnerToursBookings,
              name: AppRouteNames.partnerToursBookings,
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
          path: '/${AppRouteNames.accessDenied}',
          name: AppRouteNames.accessDenied,
          parentNavigatorKey: AppRouteNames.navigatorKey,
          builder: (context, state) => const AccessDeniedView(),
        ),
      ],
    );
  }
}
