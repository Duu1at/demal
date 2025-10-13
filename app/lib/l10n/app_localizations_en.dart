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
  String get onboardingSubTitle1 =>
      'Hundreds of weekend offers in one convenient feed';

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
}
