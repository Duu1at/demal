import 'package:go_router/go_router.dart';
import 'package:app/app/router/route_metadata.dart';
import 'package:app/app/router/app_route_names.dart';

abstract class AppRouteMetadataResolver {
  static const Map<String, RouteMetadata> byName = {
    AppRouteNames.root: RouteMetadata.public,

    AppRouteNames.login: RouteMetadata.guestOnly,
    AppRouteNames.otp: RouteMetadata.guestOnly,

    AppRouteNames.settings: RouteMetadata.public,
    AppRouteNames.settingsAboutUs: RouteMetadata.public,

    AppRouteNames.clientTourDetails: RouteMetadata.public,
    AppRouteNames.clientTourFilters: RouteMetadata.public,

    AppRouteNames.clientTourTickets: RouteMetadata.clientOnly,
    AppRouteNames.clientBookingDetails: RouteMetadata.clientOnly,
    AppRouteNames.clientBookingStatus: RouteMetadata.clientOnly,

    AppRouteNames.partner: RouteMetadata.partnerOnly,
    AppRouteNames.partnerCreateTour: RouteMetadata.partnerOnly,
    AppRouteNames.partnerEditTour: RouteMetadata.partnerOnly,
    AppRouteNames.partnerToursBookings: RouteMetadata.partnerOnly,
    AppRouteNames.partnerVerification: RouteMetadata.partnerOnly,
    AppRouteNames.partnerVerificationStatus: RouteMetadata.partnerOnly,
    AppRouteNames.partnerVerificationRejected: RouteMetadata.partnerOnly,

    AppRouteNames.accessDenied: RouteMetadata.public,
  };

  static RouteMetadata resolve(GoRouterState state) {
    final name = state.name;
    if (name != null && byName.containsKey(name)) {
      return byName[name]!;
    }
    return RouteMetadata.authenticated;
  }
}
