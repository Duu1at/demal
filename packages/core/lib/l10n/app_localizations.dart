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

  /// No description provided for @verificationStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Status'**
  String get verificationStatusTitle;

  /// No description provided for @editTourTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Tour'**
  String get editTourTitle;

  /// No description provided for @createTourTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Tour'**
  String get createTourTitle;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @tourTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Tour Title'**
  String get tourTitleLabel;

  /// No description provided for @tourTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Lake Issyk-Kul Tour'**
  String get tourTitleHint;

  /// No description provided for @tourTypeExampleHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Active rest, Excursion'**
  String get tourTypeExampleHint;

  /// No description provided for @tourLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Where the tour takes place'**
  String get tourLocationHint;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @dateFormatHint.
  ///
  /// In en, this message translates to:
  /// **'DD.MM.YYYY'**
  String get dateFormatHint;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @timeFormatHint.
  ///
  /// In en, this message translates to:
  /// **'HH:MM'**
  String get timeFormatHint;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @priceMustBeGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Price must be greater than 0'**
  String get priceMustBeGreaterThanZero;

  /// No description provided for @currencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyLabel;

  /// No description provided for @availableSpotsLabel.
  ///
  /// In en, this message translates to:
  /// **'Available Spots'**
  String get availableSpotsLabel;

  /// No description provided for @spotsCountHint.
  ///
  /// In en, this message translates to:
  /// **'Number of spots'**
  String get spotsCountHint;

  /// No description provided for @spotsMustBeGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Number of spots must be greater than 0'**
  String get spotsMustBeGreaterThanZero;

  /// No description provided for @detailedDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Detailed tour description'**
  String get detailedDescriptionHint;

  /// No description provided for @meetingPointLabel.
  ///
  /// In en, this message translates to:
  /// **'Meeting Point'**
  String get meetingPointLabel;

  /// No description provided for @meetingPointHint.
  ///
  /// In en, this message translates to:
  /// **'Meeting place address'**
  String get meetingPointHint;

  /// No description provided for @whatToBringLabel.
  ///
  /// In en, this message translates to:
  /// **'What to bring'**
  String get whatToBringLabel;

  /// No description provided for @whatToBringHint.
  ///
  /// In en, this message translates to:
  /// **'Recommendations for participants'**
  String get whatToBringHint;

  /// No description provided for @mainImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Main Image *'**
  String get mainImageLabel;

  /// No description provided for @addMainImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Add main image'**
  String get addMainImageLabel;

  /// No description provided for @galleryImagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Image Gallery *'**
  String get galleryImagesLabel;

  /// No description provided for @maxImagesCountError.
  ///
  /// In en, this message translates to:
  /// **'Maximum 10 images'**
  String get maxImagesCountError;

  /// No description provided for @addCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addCountLabel;

  /// No description provided for @addItemHint.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get addItemHint;

  /// No description provided for @addAtLeastOneItemError.
  ///
  /// In en, this message translates to:
  /// **'Add at least one item'**
  String get addAtLeastOneItemError;

  /// No description provided for @toursBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tours Bookings'**
  String get toursBookingsTitle;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @otpMessage.
  ///
  /// In en, this message translates to:
  /// **'A 6-digit OTP code was sent to {phone}'**
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
  /// **'Choose file'**
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

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validationError;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @pleaseTryLater.
  ///
  /// In en, this message translates to:
  /// **'Please try again later or contact support'**
  String get pleaseTryLater;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount: {amount}'**
  String totalAmount(Object amount);

  /// No description provided for @failedToLoadTickets.
  ///
  /// In en, this message translates to:
  /// **'Failed to load tickets'**
  String get failedToLoadTickets;

  /// No description provided for @failedToLoadNextPage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load next page'**
  String get failedToLoadNextPage;

  /// No description provided for @checkInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Check internet connection'**
  String get checkInternetConnection;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @tourBooked.
  ///
  /// In en, this message translates to:
  /// **'Your tour is booked!'**
  String get tourBooked;

  /// No description provided for @myTour.
  ///
  /// In en, this message translates to:
  /// **'My Tour'**
  String get myTour;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount}'**
  String pay(Object amount);

  /// No description provided for @whatIsIncluded.
  ///
  /// In en, this message translates to:
  /// **'What is included'**
  String get whatIsIncluded;

  /// No description provided for @whatIsNotIncluded.
  ///
  /// In en, this message translates to:
  /// **'Not included'**
  String get whatIsNotIncluded;

  /// No description provided for @tourProgram.
  ///
  /// In en, this message translates to:
  /// **'Tour Program'**
  String get tourProgram;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @gatheringPlace.
  ///
  /// In en, this message translates to:
  /// **'Gathering Place'**
  String get gatheringPlace;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @anonymousUser.
  ///
  /// In en, this message translates to:
  /// **'Anonymous User'**
  String get anonymousUser;

  /// No description provided for @failedToLoadReviews.
  ///
  /// In en, this message translates to:
  /// **'Error loading reviews.'**
  String get failedToLoadReviews;

  /// No description provided for @tourOrganizer.
  ///
  /// In en, this message translates to:
  /// **'Tour Organizer'**
  String get tourOrganizer;

  /// No description provided for @bookTour.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get bookTour;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signInGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign In with Google'**
  String get signInGoogle;

  /// No description provided for @signInApple.
  ///
  /// In en, this message translates to:
  /// **'Sign In with Apple'**
  String get signInApple;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Code'**
  String get enterCode;

  /// No description provided for @enter6Digits.
  ///
  /// In en, this message translates to:
  /// **'Enter 6 digits'**
  String get enter6Digits;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deletePhoto.
  ///
  /// In en, this message translates to:
  /// **'Delete Photo'**
  String get deletePhoto;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get fieldRequired;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get statusConfirmed;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @dateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Date and Time: '**
  String get dateAndTime;

  /// No description provided for @seatsCount.
  ///
  /// In en, this message translates to:
  /// **'Seats count: '**
  String get seatsCount;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get statusLabel;

  /// No description provided for @noTickets.
  ///
  /// In en, this message translates to:
  /// **'You have no tickets yet'**
  String get noTickets;

  /// No description provided for @contactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get contactDetails;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @guests.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get guests;

  /// No description provided for @noToursFound.
  ///
  /// In en, this message translates to:
  /// **'No tours found'**
  String get noToursFound;

  /// No description provided for @adjustSearch.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search'**
  String get adjustSearch;

  /// No description provided for @failedToLoadTours.
  ///
  /// In en, this message translates to:
  /// **'Failed to load tours'**
  String get failedToLoadTours;

  /// No description provided for @filtersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersTitle;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @locationHint.
  ///
  /// In en, this message translates to:
  /// **'City, region...'**
  String get locationHint;

  /// No description provided for @tourTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Tour type'**
  String get tourTypeLabel;

  /// No description provided for @tourTypeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. hiking, safari'**
  String get tourTypeHint;

  /// No description provided for @dateRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get dateRangeLabel;

  /// No description provided for @dateFromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get dateFromLabel;

  /// No description provided for @dateToLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get dateToLabel;

  /// No description provided for @priceRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Price range (min - max)'**
  String get priceRangeLabel;

  /// No description provided for @minHint.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get minHint;

  /// No description provided for @maxHint.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get maxHint;

  /// No description provided for @sortByLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortByLabel;

  /// No description provided for @sortDateAsc.
  ///
  /// In en, this message translates to:
  /// **'Date ↑'**
  String get sortDateAsc;

  /// No description provided for @sortDateDesc.
  ///
  /// In en, this message translates to:
  /// **'Date ↓'**
  String get sortDateDesc;

  /// No description provided for @sortPriceAsc.
  ///
  /// In en, this message translates to:
  /// **'Price ↑'**
  String get sortPriceAsc;

  /// No description provided for @sortPriceDesc.
  ///
  /// In en, this message translates to:
  /// **'Price ↓'**
  String get sortPriceDesc;

  /// No description provided for @sortRatingDesc.
  ///
  /// In en, this message translates to:
  /// **'Rating ↓'**
  String get sortRatingDesc;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @invalidDateRange.
  ///
  /// In en, this message translates to:
  /// **'Invalid date range'**
  String get invalidDateRange;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @notSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get notSpecified;

  /// No description provided for @profileInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Profile photo, name, description'**
  String get profileInfoSubtitle;

  /// No description provided for @becomeOrganizerTitle.
  ///
  /// In en, this message translates to:
  /// **'Become a Tour Operator'**
  String get becomeOrganizerTitle;

  /// No description provided for @becomeOrganizerAction.
  ///
  /// In en, this message translates to:
  /// **'Become an organizer'**
  String get becomeOrganizerAction;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action is irreversible, and all your data will be permanently deleted.'**
  String get deleteAccountConfirmation;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logoutTitle;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of your account?'**
  String get logoutConfirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccess;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneLabel;

  /// No description provided for @notSpecifiedEmail.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get notSpecifiedEmail;

  /// No description provided for @roleUpgradeTitle.
  ///
  /// In en, this message translates to:
  /// **'Become an Organizer'**
  String get roleUpgradeTitle;

  /// No description provided for @roleUpgradeDescription.
  ///
  /// In en, this message translates to:
  /// **'After switching roles to an organizer, client functions will be unavailable. You can create and manage tours but cannot book tours as a client.'**
  String get roleUpgradeDescription;

  /// No description provided for @searchTours.
  ///
  /// In en, this message translates to:
  /// **'Search tours'**
  String get searchTours;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @tourFallback.
  ///
  /// In en, this message translates to:
  /// **'Tour'**
  String get tourFallback;

  /// No description provided for @reviewsCountParam.
  ///
  /// In en, this message translates to:
  /// **'({count} reviews)'**
  String reviewsCountParam(int count);

  /// No description provided for @noTitle.
  ///
  /// In en, this message translates to:
  /// **'No title'**
  String get noTitle;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @currencySom.
  ///
  /// In en, this message translates to:
  /// **'som'**
  String get currencySom;

  /// No description provided for @seats.
  ///
  /// In en, this message translates to:
  /// **'Seats'**
  String get seats;

  /// No description provided for @noToursYet.
  ///
  /// In en, this message translates to:
  /// **'You have no tours yet'**
  String get noToursYet;

  /// No description provided for @createFirstTourAction.
  ///
  /// In en, this message translates to:
  /// **'Create your first tour and start receiving bookings'**
  String get createFirstTourAction;

  /// No description provided for @failedToLoadToursTitle.
  ///
  /// In en, this message translates to:
  /// **'Failed to load tours'**
  String get failedToLoadToursTitle;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @checkInternetAndTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Check internet connection and try again'**
  String get checkInternetAndTryAgain;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @toMain.
  ///
  /// In en, this message translates to:
  /// **'Go to main'**
  String get toMain;

  /// No description provided for @participantsCount.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get participantsCount;

  /// No description provided for @amountPaid.
  ///
  /// In en, this message translates to:
  /// **'Amount paid'**
  String get amountPaid;

  /// No description provided for @noBookingsForTour.
  ///
  /// In en, this message translates to:
  /// **'No bookings for this tour yet'**
  String get noBookingsForTour;

  /// No description provided for @bookingStatusPendingShort.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bookingStatusPendingShort;

  /// No description provided for @bookingStatusConfirmedShort.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get bookingStatusConfirmedShort;

  /// No description provided for @bookingStatusPaidShort.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get bookingStatusPaidShort;

  /// No description provided for @bookingStatusCompletedShort.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get bookingStatusCompletedShort;

  /// No description provided for @bookingStatusCancelledShort.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get bookingStatusCancelledShort;

  /// No description provided for @bookingStatusUnknownShort.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get bookingStatusUnknownShort;

  /// No description provided for @documentUploaded.
  ///
  /// In en, this message translates to:
  /// **'Document Uploaded'**
  String get documentUploaded;

  /// No description provided for @ipCertificateScan.
  ///
  /// In en, this message translates to:
  /// **'IE certificate scan'**
  String get ipCertificateScan;

  /// No description provided for @uploadIpCertificateHint.
  ///
  /// In en, this message translates to:
  /// **'Please upload a scan of your IE certificate in good quality. The document can also be taken from the Tunduk app.'**
  String get uploadIpCertificateHint;

  /// No description provided for @verificationCongratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get verificationCongratulations;

  /// No description provided for @verificationRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Request rejected'**
  String get verificationRejectedTitle;

  /// No description provided for @verificationPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Request under review'**
  String get verificationPendingTitle;

  /// No description provided for @verificationApprovedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your application is approved. You have now become a partner and can create tours.'**
  String get verificationApprovedDesc;

  /// No description provided for @verificationRejectedDescDefault.
  ///
  /// In en, this message translates to:
  /// **'Your application was rejected by the moderator. Please correct the data and submit again.'**
  String get verificationRejectedDescDefault;

  /// No description provided for @verificationRejectedReason.
  ///
  /// In en, this message translates to:
  /// **'Rejection reason: {reason}'**
  String verificationRejectedReason(Object reason);

  /// No description provided for @verificationPendingDesc.
  ///
  /// In en, this message translates to:
  /// **'Your verification request has been submitted and is under review. Review takes 1 to 2 business days.'**
  String get verificationPendingDesc;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @availableSpots.
  ///
  /// In en, this message translates to:
  /// **'Available spots'**
  String get availableSpots;

  /// No description provided for @bookingDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetailsTitle;

  /// No description provided for @whatsappNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Provide the number linked to WhatsApp'**
  String get whatsappNumberHint;

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoonTitle;

  /// No description provided for @featureInDevelopmentMessage.
  ///
  /// In en, this message translates to:
  /// **'This feature is under development. Expect it in the next versions of the app.'**
  String get featureInDevelopmentMessage;

  /// No description provided for @submittedAt.
  ///
  /// In en, this message translates to:
  /// **'Submitted: {date}'**
  String submittedAt(Object date);

  /// No description provided for @resubmitRequest.
  ///
  /// In en, this message translates to:
  /// **'Resubmit request'**
  String get resubmitRequest;

  /// No description provided for @updateStatus.
  ///
  /// In en, this message translates to:
  /// **'Update status'**
  String get updateStatus;

  /// No description provided for @waitingForNetwork.
  ///
  /// In en, this message translates to:
  /// **'Waiting for network...'**
  String get waitingForNetwork;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Error Occurred'**
  String get errorOccurred;

  /// No description provided for @technicalErrorContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Technical error. Please contact support.'**
  String get technicalErrorContactSupport;

  /// No description provided for @catchConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get catchConnectionError;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @updateRequired.
  ///
  /// In en, this message translates to:
  /// **'Update Required'**
  String get updateRequired;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get updateAvailable;

  /// No description provided for @updateRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'To continue, please update the app to the latest version'**
  String get updateRequiredMessage;

  /// No description provided for @updateAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'A new version of the application is available. Do you want to update now?'**
  String get updateAvailableMessage;

  /// No description provided for @updateLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get updateLater;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateNow;
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
