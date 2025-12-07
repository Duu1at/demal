import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('ky'), Locale('ru')];

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'All tours in one place'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubTitle1.
  ///
  /// In en, this message translates to:
  /// **'Hundreds of weekend offers in one convenient feed'**
  String get onboardingSubTitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Verified guides'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubTitle2.
  ///
  /// In en, this message translates to:
  /// **'Read honest reviews from real travelers'**
  String get onboardingSubTitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Book in 3 clicks'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubTitle3.
  ///
  /// In en, this message translates to:
  /// **'No long chats, screenshots or waiting'**
  String get onboardingSubTitle3;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @otpMessage.
  ///
  /// In en, this message translates to:
  /// **'A 4-digit OTP code was sent to {phone}'**
  String otpMessage(Object phone);

  /// No description provided for @selectLang.
  ///
  /// In en, this message translates to:
  /// **'Select a language'**
  String get selectLang;

  /// No description provided for @selectTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose a theme'**
  String get selectTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @lastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last Update: '**
  String get lastUpdate;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'This application combines all recreation offers in Kyrgyzstan from reliable organizers.'**
  String get appDescription;

  /// No description provided for @withUsYouGet.
  ///
  /// In en, this message translates to:
  /// **'With us you get: '**
  String get withUsYouGet;

  /// No description provided for @timeSavingTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Saving:'**
  String get timeSavingTitle;

  /// No description provided for @timeSavingDescription.
  ///
  /// In en, this message translates to:
  /// **'All relevant tours for any date are now collected in one convenient feed. Stop wasting hours searching on social networks.'**
  String get timeSavingDescription;

  /// No description provided for @safetyAndTrustTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety and Trust: '**
  String get safetyAndTrustTitle;

  /// No description provided for @safetyAndTrustDescription.
  ///
  /// In en, this message translates to:
  /// **'we cooperate only with reliable partners. You can read honest reviews and ratings before making a choice.'**
  String get safetyAndTrustDescription;

  /// No description provided for @simplicityAndConvenienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Simplicity and Convenience:'**
  String get simplicityAndConvenienceTitle;

  /// No description provided for @simplicityAndConvenienceDescription.
  ///
  /// In en, this message translates to:
  /// **'book and pay for tours online in the app with a few clicks.'**
  String get simplicityAndConvenienceDescription;

  /// No description provided for @myTickets.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get myTickets;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'To Share'**
  String get shareApp;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version: '**
  String get version;

  /// No description provided for @partnerVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get partnerVerificationTitle;

  /// No description provided for @companyNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyNameLabel;

  /// No description provided for @companyNameHint.
  ///
  /// In en, this message translates to:
  /// **'Example: LLC \"TourClub\"'**
  String get companyNameHint;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Example: We offer tours to mountains, forests, deserts, etc.'**
  String get descriptionHint;

  /// No description provided for @cardNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumberLabel;

  /// No description provided for @cardNumberHint.
  ///
  /// In en, this message translates to:
  /// **'XXXX XXXX XXXX XXXX'**
  String get cardNumberHint;

  /// No description provided for @attachDocumentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Attach documents or photos of documents'**
  String get attachDocumentsTitle;

  /// No description provided for @realPhotoHint.
  ///
  /// In en, this message translates to:
  /// **'Please attach a real photo of the document'**
  String get realPhotoHint;

  /// No description provided for @documentChip.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get documentChip;

  /// No description provided for @chooseFilesButton.
  ///
  /// In en, this message translates to:
  /// **'Choose files'**
  String get chooseFilesButton;

  /// No description provided for @takePhotoButton.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhotoButton;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'I agree with the terms of use and personal data processing'**
  String get termsAgreement;

  /// No description provided for @submitForVerification.
  ///
  /// In en, this message translates to:
  /// **'Submit for verification'**
  String get submitForVerification;

  /// No description provided for @companyNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Company name is required'**
  String get companyNameRequired;

  /// No description provided for @descriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get descriptionRequired;

  /// No description provided for @cardNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Card number must contain 16 digits'**
  String get cardNumberRequired;

  /// No description provided for @documentsRequired.
  ///
  /// In en, this message translates to:
  /// **'Documents are required'**
  String get documentsRequired;

  /// No description provided for @termsRequired.
  ///
  /// In en, this message translates to:
  /// **'You must agree to the terms'**
  String get termsRequired;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ky', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ky':
      return AppLocalizationsKy();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
