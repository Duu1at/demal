import 'package:flutter/material.dart';

abstract class AppRouteNames {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static const login = 'login';
  static const otp = 'otp';

  static const settings = 'settings';
  static const settingsAboutUs = 'settingsAboutUs';
  static const settingsEditProfile = 'settingsEditProfile';

  static const client = 'client';
  static const clientTourDetails = 'clientTourDetails';
  static const clientTourTickets = 'clientTourTickets';
  static const clientBookingDetails = 'clientBookingDetails';
  static const clientTourFilters = 'clientTourFilters';
  static const clientBookingStatus = 'clientBookingStatus';

  static const partner = 'partner';
  static const partnerCreateTour = 'partnerCreateTour';
  static const partnerEditTour = 'partnerEditTour';
  static const partnerToursBookings = 'partnerToursBookings';
  static const partnerVerification = 'partnerVerification';
  static const partnerVerificationStatus = 'partnerVerificationStatus';
}
