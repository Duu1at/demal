// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class AppLocalizationsKy extends AppLocalizations {
  AppLocalizationsKy([String locale = 'ky']) : super(locale);

  @override
  String get next => 'Кийинкиси';

  @override
  String otpMessage(Object phone) {
    return '$phone номерине 6 сандык OTP коду жиберилди';
  }

  @override
  String get selectLang => 'Тилди тандаңыз';

  @override
  String get selectTheme => 'Теманы тандаңыз';

  @override
  String get lightTheme => 'Ачык тема';

  @override
  String get darkTheme => 'Караңгы тема';

  @override
  String get aboutUs => 'Биз жөнүндө';

  @override
  String get lastUpdate => 'Акыркы жаңылануу:';

  @override
  String get contactUs => 'Биз менен байланышыңыз';

  @override
  String get appDescription =>
      'Бул колдонмо ишенимдүү уюштуруучулардан Кыргызстандагы эс алуу боюнча бардык сунуштарды бириктирет.';

  @override
  String get withUsYouGet => 'Биз менен сиз төмөнкүлөргө ээ болосуз:';

  @override
  String get timeSavingTitle => 'Убакытты үнөмдөө: ';

  @override
  String get timeSavingDescription =>
      'Бардык актуалдуу турлар каалаган датага ыңгайлуу бир лентага чогултулган. Социалдык тармактардан издөөгө мындан ары убакыт коротпоңуз';

  @override
  String get safetyAndTrustTitle => 'Коопсуздук жана ишеним: ';

  @override
  String get safetyAndTrustDescription =>
      'Биз ишенимдүү өнөктөштөр менен гана кызматташабыз. Тандоо жасоодон мурун калыс пикирлер жана рейтингдер менен тааныша аласыз.';

  @override
  String get simplicityAndConvenienceTitle => 'Жөнөкөйлүк жана ыңгайлуулук: ';

  @override
  String get simplicityAndConvenienceDescription =>
      'Турларды онлайн режиминде колдонмодо бир нече басуу менен брондоңуз жана төлөңүз.';

  @override
  String get myTickets => 'Менин билеттерим';

  @override
  String get appTheme => 'Тиркеменин темасы';

  @override
  String get profile => 'Профиль';

  @override
  String get appLanguage => 'Тиркеменин тили';

  @override
  String get shareApp => 'Бөлүшүү';

  @override
  String get logOut => 'Чыгуу';

  @override
  String get deleteAccount => 'Аккаунтту өчүрүү';

  @override
  String get version => 'Версия: ';

  @override
  String get partnerVerificationTitle => 'Текшерүү';

  @override
  String get companyNameLabel => 'Компаниянын аталышы';

  @override
  String get companyNameHint => 'Мисалы, \"Турклуб\" ЖЧКсы';

  @override
  String get descriptionLabel => 'Сүрөттөмө';

  @override
  String get descriptionHint => 'Мисалы, биз тоолорго, токойлорго, чөлдөргө турларды сунуштайбыз ж.б.';

  @override
  String get cardNumberLabel => 'Картанын номери';

  @override
  String get cardNumberHint => 'XXXX XXXX XXXX XXXX';

  @override
  String get attachDocumentsTitle => 'Документтерди же документтердин сүрөттөрүн тиркеңиз';

  @override
  String get realPhotoHint => 'Сураныч, документтин чыныгы сүрөтүн тиркеңиз';

  @override
  String get documentChip => 'Документ';

  @override
  String get chooseFilesButton => 'Файл тандоо';

  @override
  String get takePhotoButton => 'Сүрөткө тартуу';

  @override
  String get termsAgreement => 'Мен колдонуу шарттарына жана жеке маалыматтарды иштетүүгө макулмун';

  @override
  String get submitForVerification => 'Текшерүүгө жөнөтүү';

  @override
  String get companyNameRequired => 'Компаниянын аталышы милдеттүү';

  @override
  String get descriptionRequired => 'Сүрөттөмө милдеттүү';

  @override
  String get cardNumberRequired => 'Картанын номери 16 сандан турушу керек';

  @override
  String get documentsRequired => 'Документтерди тиркөө зарыл';

  @override
  String get termsRequired => 'Шарттарга макул болуу зарыл';

  @override
  String get validationError => 'Валидация катасы';

  @override
  String get error => 'Ката';

  @override
  String get somethingWentWrong => 'Бир нерсе туура эмес болду';

  @override
  String get pleaseTryLater => 'Сураныч, кийинчерээк кайталап көрүңүз же колдоо кызматына кайрылыңыз';

  @override
  String get search => 'Издөө';

  @override
  String totalAmount(Object amount) {
    return 'Жалпы сумма: $amount';
  }

  @override
  String get failedToLoadTickets => 'Билеттерди жүктөө ишке ашкан жок';

  @override
  String get failedToLoadNextPage => 'Кийинки баракты жүктөө ишке ашкан жок';

  @override
  String get checkInternetConnection => 'Интернетке туташууну текшериңиз';

  @override
  String get retry => 'Кайталоо';

  @override
  String get tourBooked => 'Тур брондолду!';

  @override
  String get myTour => 'Менин турум';

  @override
  String pay(Object amount) {
    return 'Төлөө $amount';
  }

  @override
  String get whatIsIncluded => 'Эмне камтылган';

  @override
  String get whatIsNotIncluded => 'Эмне камтылган эмес';

  @override
  String get tourProgram => 'Тур программасы';

  @override
  String get description => 'Сүрөттөмө';

  @override
  String get gatheringPlace => 'Чогулуучу жер';

  @override
  String get hide => 'Жашыруу';

  @override
  String get showMore => 'Кененирээк көрсөтүү';

  @override
  String get reviews => 'Пикирлер';

  @override
  String get noReviewsYet => 'Азырынча пикирлер жок';

  @override
  String get anonymousUser => 'Анонимдүү колдонуучу';

  @override
  String get failedToLoadReviews => 'Пикирлерди жүктөөдө ката кетти.';

  @override
  String get tourOrganizer => 'Тур уюштуруучусу';

  @override
  String get bookTour => 'Турду брондоо';

  @override
  String get welcome => 'Кош келиңиз!';

  @override
  String get signIn => 'Кирүү';

  @override
  String get signInGoogle => 'Google аркылуу кирүү';

  @override
  String get signInApple => 'Apple аркылуу кирүү';

  @override
  String get verify => 'Текшерүү';

  @override
  String get enterCode => 'Кодду киргизиңиз';

  @override
  String get enter6Digits => '6 сан киргизиңиз';

  @override
  String get resendCode => 'Кайра жөнөтүү';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерея';

  @override
  String get delete => 'Өчүрүү';

  @override
  String get deletePhoto => 'Сүрөттү өчүрүү';

  @override
  String get fieldRequired => 'Бул талааны толтуруу милдеттүү';

  @override
  String get statusPending => 'Ырастоону күтүүдө';

  @override
  String get statusConfirmed => 'Ырасталды';

  @override
  String get statusPaid => 'Төлөндү';

  @override
  String get statusCompleted => 'Аяктады';

  @override
  String get statusCancelled => 'Жокко чыгарылды';

  @override
  String get statusUnknown => 'Белгисиз';

  @override
  String get dateAndTime => 'Күнү жана убактысы: ';

  @override
  String get seatsCount => 'Орун саны: ';

  @override
  String get total => 'Жалпы';

  @override
  String get statusLabel => 'Абалы: ';

  @override
  String get noTickets => 'Сизде азырынча билеттер жок';

  @override
  String get contactDetails => 'Байланыш маалыматтары';

  @override
  String get fullName => 'Аты-жөнү';

  @override
  String get guests => 'Коноктор';

  @override
  String get noToursFound => 'Турлар табылган жок';

  @override
  String get adjustSearch => 'Издөө параметрлерин өзгөртүп көрүңүз';

  @override
  String get failedToLoadTours => 'Турларды жүктөө ишке ашкан жок';

  @override
  String get filtersTitle => 'Фильтрлер';

  @override
  String get reset => 'Кайтаруу';

  @override
  String get locationLabel => 'Жайгашкан жери';

  @override
  String get locationHint => 'Шаар, регион...';

  @override
  String get tourTypeLabel => 'Тур түрү';

  @override
  String get tourTypeHint => 'Мисалы, хайкинг, сафари';

  @override
  String get dateRangeLabel => 'Даталар диапазону';

  @override
  String get dateFromLabel => 'Баштап';

  @override
  String get dateToLabel => 'Чейин';

  @override
  String get priceRangeLabel => 'Баасы (мин - макс)';

  @override
  String get minHint => 'Мин';

  @override
  String get maxHint => 'Макс';

  @override
  String get sortByLabel => 'Сорттоо';

  @override
  String get sortDateAsc => 'Дата ↑';

  @override
  String get sortDateDesc => 'Дата ↓';

  @override
  String get sortPriceAsc => 'Баасы ↑';

  @override
  String get sortPriceDesc => 'Баасы ↓';

  @override
  String get sortRatingDesc => 'Рейтинг ↓';

  @override
  String get apply => 'Колдонуу';

  @override
  String get invalidDateRange => 'Жараксыз даталар диапазону';

  @override
  String get settingsTitle => 'Орнотуулар';

  @override
  String get notSpecified => 'Көрсөтүлгөн эмес';

  @override
  String get profileInfoSubtitle => 'Профиль сүрөтү, аты, сүрөттөмө';

  @override
  String get becomeOrganizerTitle => 'Туроператор болуу';

  @override
  String get becomeOrganizerAction => 'Уюштуруучу болуу';

  @override
  String get deleteAccountTitle => 'Аккаунтту өчүрүү';

  @override
  String get deleteAccountConfirmation =>
      'Аккаунтуңузду чын эле өчүргүңүз келеби? Бул аракетти артка кайтаруу мүмкүн эмес жана бардык маалыматтарыңыз биротоло өчүрүлөт.';

  @override
  String get logoutTitle => 'Аккаунттан чыгуу';

  @override
  String get logoutConfirmation => 'Аккаунтуңуздан чын эле чыккыңыз келеби?';

  @override
  String get cancel => 'Жокко чыгаруу';

  @override
  String get confirm => 'Ырастоо';

  @override
  String get profileUpdatedSuccess => 'Профиль ийгиликтүү жаңыланды';

  @override
  String get nameLabel => 'Аты';

  @override
  String get phoneLabel => 'Телефон номери';

  @override
  String get notSpecifiedEmail => 'Көрсөтүлгөн эмес';

  @override
  String get roleUpgradeTitle => 'Уюштуруучу болуу';

  @override
  String get roleUpgradeDescription =>
      'Ролду уюштуруучуга алмаштыргандан кийин, кардар функциялары жеткиликсиз болуп калат. Сиз турларды түзүп жана башкара аласыз, бирок кардар катары турларды брондой албайсыз.';

  @override
  String get searchTours => 'Турларды издөө';

  @override
  String get email => 'Электрондук почта';

  @override
  String get tourFallback => 'Тур';

  @override
  String reviewsCountParam(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return '($countString пикир)';
  }
}
