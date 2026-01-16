// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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

  @override
  String get partnerVerificationTitle => 'Verification';

  @override
  String get companyNameLabel => 'Company Name';

  @override
  String get companyNameHint => 'Example: LLC \"TourClub\"';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHint => 'Example: We offer tours to mountains, forests, deserts, etc.';

  @override
  String get cardNumberLabel => 'Card Number';

  @override
  String get cardNumberHint => 'XXXX XXXX XXXX XXXX';

  @override
  String get attachDocumentsTitle => 'Attach documents or photos of documents';

  @override
  String get realPhotoHint => 'Please attach a real photo of the document';

  @override
  String get documentChip => 'Document';

  @override
  String get chooseFilesButton => 'Choose file';

  @override
  String get takePhotoButton => 'Take a photo';

  @override
  String get termsAgreement => 'I agree with the terms of use and personal data processing';

  @override
  String get submitForVerification => 'Submit for verification';

  @override
  String get companyNameRequired => 'Company name is required';

  @override
  String get descriptionRequired => 'Description is required';

  @override
  String get cardNumberRequired => 'Card number must contain 16 digits';

  @override
  String get documentsRequired => 'Documents are required';

  @override
  String get termsRequired => 'You must agree to the terms';

  @override
  String get validationError => 'Validation Error';

  @override
  String get error => 'Error';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get pleaseTryLater => 'Please try again later or contact support';

  @override
  String get search => 'Search';

  @override
  String totalAmount(Object amount) {
    return 'Total Amount: $amount';
  }

  @override
  String get failedToLoadTickets => 'Failed to load tickets';

  @override
  String get failedToLoadNextPage => 'Failed to load next page';

  @override
  String get checkInternetConnection => 'Check internet connection';

  @override
  String get retry => 'Retry';

  @override
  String get tourBooked => 'Your tour is booked!';

  @override
  String get myTour => 'My Tour';

  @override
  String pay(Object amount) {
    return 'Pay $amount';
  }

  @override
  String get whatIsIncluded => 'What is included';

  @override
  String get whatIsNotIncluded => 'Not included';

  @override
  String get tourProgram => 'Tour Program';

  @override
  String get description => 'Description';

  @override
  String get gatheringPlace => 'Gathering Place';

  @override
  String get hide => 'Hide';

  @override
  String get showMore => 'Show more';

  @override
  String get reviews => 'Reviews';

  @override
  String get noReviewsYet => 'No reviews yet';

  @override
  String get anonymousUser => 'Anonymous User';

  @override
  String get failedToLoadReviews => 'Error loading reviews.';

  @override
  String get tourOrganizer => 'Tour Organizer';

  @override
  String get bookTour => 'Book';

  @override
  String get welcome => 'Welcome!';

  @override
  String get signIn => 'Sign In';

  @override
  String get signInGoogle => 'Sign In with Google';

  @override
  String get signInApple => 'Sign In with Apple';

  @override
  String get verify => 'Verify';

  @override
  String get enterCode => 'Enter Code';

  @override
  String get enter6Digits => 'Enter 6 digits';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get delete => 'Delete';

  @override
  String get deletePhoto => 'Delete Photo';

  @override
  String get fieldRequired => 'Field is required';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusConfirmed => 'Confirmed';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get dateAndTime => 'Date and Time: ';

  @override
  String get seatsCount => 'Seats count: ';

  @override
  String get total => 'Total';

  @override
  String get statusLabel => 'Status: ';

  @override
  String get noTickets => 'You have no tickets yet';

  @override
  String get contactDetails => 'Contact Details';

  @override
  String get fullName => 'Full Name';

  @override
  String get guests => 'Guests';

  @override
  String get noToursFound => 'No tours found';

  @override
  String get adjustSearch => 'Try adjusting your search';

  @override
  String get failedToLoadTours => 'Failed to load tours';

  @override
  String get filtersTitle => 'Filters';

  @override
  String get reset => 'Reset';

  @override
  String get locationLabel => 'Location';

  @override
  String get locationHint => 'City, region...';

  @override
  String get tourTypeLabel => 'Tour type';

  @override
  String get tourTypeHint => 'e.g. hiking, safari';

  @override
  String get dateRangeLabel => 'Date range';

  @override
  String get dateFromLabel => 'From';

  @override
  String get dateToLabel => 'To';

  @override
  String get priceRangeLabel => 'Price range (min - max)';

  @override
  String get minHint => 'Min';

  @override
  String get maxHint => 'Max';

  @override
  String get sortByLabel => 'Sort by';

  @override
  String get sortDateAsc => 'Date ↑';

  @override
  String get sortDateDesc => 'Date ↓';

  @override
  String get sortPriceAsc => 'Price ↑';

  @override
  String get sortPriceDesc => 'Price ↓';

  @override
  String get sortRatingDesc => 'Rating ↓';

  @override
  String get apply => 'Apply';

  @override
  String get invalidDateRange => 'Invalid date range';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get profileInfoSubtitle => 'Profile photo, name, description';

  @override
  String get becomeOrganizerTitle => 'Become a Tour Operator';

  @override
  String get becomeOrganizerAction => 'Become an organizer';

  @override
  String get deleteAccountTitle => 'Delete Account';

  @override
  String get deleteAccountConfirmation =>
      'Are you sure you want to delete your account? This action is irreversible, and all your data will be permanently deleted.';

  @override
  String get logoutTitle => 'Log Out';

  @override
  String get logoutConfirmation => 'Are you sure you want to log out of your account?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully';

  @override
  String get nameLabel => 'Name';

  @override
  String get phoneLabel => 'Phone Number';

  @override
  String get notSpecifiedEmail => 'Not specified';

  @override
  String get roleUpgradeTitle => 'Become an Organizer';

  @override
  String get roleUpgradeDescription =>
      'After switching roles to an organizer, client functions will be unavailable. You can create and manage tours but cannot book tours as a client.';

  @override
  String get searchTours => 'Search tours';

  @override
  String get email => 'Email';

  @override
  String get tourFallback => 'Tour';

  @override
  String reviewsCountParam(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return '($countString reviews)';
  }
}
