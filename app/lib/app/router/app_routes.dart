import 'package:flutter/material.dart';

abstract class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  // Onboarding
  static const initialSettings = '/initial-settings';
  static const onboardingOne = 'onboarding-one';
  static const onboardingTwo = 'onboarding-two';
  static const onboardingThree = 'onboarding-three';

  // Auth
  static const login = '/login';
  static const otp = 'otp';

  // Client
  static const client = '/client';
  static const clientTourDetails = 'tour/:tourId';
  static const clientTourTickets = 'tickets';
  static const clientTourFilters = 'filters';
  static const clientBookingDetails = 'booking-details';
  static const clientBookingStatus = 'booking-status';

  // Partner
  static const partner = '/partner';
  static const partnerVerification = '/partner-verification';
  static const partnerVerificationStatus = '/partner-verification/status';
  static const partnerVerificationRejected = '/partner-verification/rejected';
  static const partnerCreateTour = 'create-tour';
  static const partnerEditTour = 'edit/:tourId';
  static const partnerToursBookings = 'bookings/:tourId';

  // Settings
  static const settings = '/settings';
  static const settingsAboutUs = 'about-us';

  static String clientTourDetailsPath(String tourId) => '/client/tour/$tourId';
  static String partnerEditTourPath(String tourId) => '/partner/edit/$tourId';
  static String partnerToursBookingsPath(String tourId) => '/partner/bookings/$tourId';
}
