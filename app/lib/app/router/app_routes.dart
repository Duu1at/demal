import 'package:flutter/material.dart';
import 'package:app/app/router/route_metadata.dart';

abstract class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @RouteMetadata.public
  static const root = '/';

  @RouteMetadata.guestOnly
  static const login = '/login';

  @RouteMetadata.guestOnly
  static const otp = '/otp';

  @RouteMetadata.public
  static const settings = '/settings';

  @RouteMetadata.public
  static const settingsAboutUs = '/settings/about-us';

  @RouteMetadata.clientOnly
  static const client = '/client';

  @RouteMetadata.public
  static const clientTourDetails = '/client/tour/:tourId';

  @RouteMetadata.clientOnly
  static const clientTourTickets = '/client/tickets';

  @RouteMetadata.clientOnly
  static const clientBookingDetails = '/client/booking-details';

  @RouteMetadata.clientOnly
  static const clientTourFilters = '/client/filters';

  @RouteMetadata.clientOnly
  static const clientBookingStatus = '/client/booking-status';

  @RouteMetadata.partnerOnly
  static const partner = '/partner';

  @RouteMetadata.partnerOnly
  static const partnerCreateTour = '/partner/create-tour';

  @RouteMetadata.partnerOnly
  static const partnerEditTour = '/partner/edit/:tourId';

  @RouteMetadata.partnerOnly
  static const partnerToursBookings = '/partner/bookings/:tourId';

  @RouteMetadata.partnerOnly
  static const partnerVerification = '/partner/verification';

  @RouteMetadata.partnerOnly
  static const partnerVerificationStatus = '/partner/verification/status';

  @RouteMetadata.partnerOnly
  static const partnerVerificationRejected = '/partner/verification/rejected';

  @RouteMetadata.public
  static const accessDenied = '/access-denied';

  static final Map<String, RouteMetadata> metadata = {
    root: RouteMetadata.public,
    login: RouteMetadata.guestOnly,
    otp: RouteMetadata.guestOnly,
    settings: RouteMetadata.public,
    settingsAboutUs: RouteMetadata.public,
    client: RouteMetadata.clientOnly,
    clientTourTickets: RouteMetadata.clientOnly,
    clientBookingDetails: RouteMetadata.clientOnly,
    partner: RouteMetadata.partnerOnly,
    partnerCreateTour: RouteMetadata.partnerOnly,
    accessDenied: RouteMetadata.public,
    clientTourFilters: RouteMetadata.clientOnly,
    clientBookingStatus: RouteMetadata.clientOnly,
    partnerToursBookings: RouteMetadata.partnerOnly,
    partnerVerification: RouteMetadata.partnerOnly,
    partnerVerificationStatus: RouteMetadata.partnerOnly,
    partnerVerificationRejected: RouteMetadata.partnerOnly,
  };

  static RouteMetadata getMetadata(String path) {
    if (metadata.containsKey(path)) {
      return metadata[path]!;
    }

    if (path.startsWith('/client/tour/')) {
      return RouteMetadata.public;
    }
    if (path.startsWith('/partner/edit/')) {
      return RouteMetadata.partnerOnly;
    }

    if (path.startsWith('/client')) {
      return RouteMetadata.clientOnly;
    }

    if (path.startsWith('/partner')) {
      return RouteMetadata.partnerOnly;
    }

    return RouteMetadata.authenticated;
  }
}
