// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingTitle1 => 'All tours in one place';

  @override
  String get onboardingSubTitle1 => 'Hundreds of weekend offers in one convenient feed';

  @override
  String get onboardingTitle2 => 'Verified guides';

  @override
  String get onboardingSubTitle2 => 'Read honest reviews from real travelers';

  @override
  String get onboardingTitle3 => 'Book in 3 clicks';

  @override
  String get onboardingSubTitle3 => 'No long chats, screenshots or waiting';

  @override
  String get next => 'Next';

  @override
  String otpMessage(Object phone) {
    return 'A 4-digit OTP code was sent to $phone';
  }

  @override
  String get selectLang => 'Select a language';

  @override
  String get selectTheme => 'Choose a theme';

  @override
  String get lightTheme => 'Light Theme';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get aboutUs => 'About Us';

  @override
  String get lastUpdate => 'Last Update: ';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get appDescription =>
      'This application combines all recreation offers in Kyrgyzstan from reliable organizers.';

  @override
  String get withUsYouGet => 'With us you get: ';

  @override
  String get timeSavingTitle => 'Time Saving:';

  @override
  String get timeSavingDescription =>
      'All relevant tours for any date are now collected in one convenient feed. Stop wasting hours searching on social networks.';

  @override
  String get safetyAndTrustTitle => 'Safety and Trust: ';

  @override
  String get safetyAndTrustDescription =>
      'we cooperate only with reliable partners. You can read honest reviews and ratings before making a choice.';

  @override
  String get simplicityAndConvenienceTitle => 'Simplicity and Convenience:';

  @override
  String get simplicityAndConvenienceDescription => 'book and pay for tours online in the app with a few clicks.';

  @override
  String get myTickets => 'My Tickets';

  @override
  String get appTheme => 'App Theme';

  @override
  String get profile => 'Profile';

  @override
  String get appLanguage => 'App Language';

  @override
  String get shareApp => 'To Share';

  @override
  String get logOut => 'Log Out';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get version => 'Version: ';
}
