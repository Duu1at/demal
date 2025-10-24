// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get onboardingTitle1 => 'Все туры в одном месте';

  @override
  String get onboardingSubTitle1 =>
      'Сотни предложений на выходные в одной удобной ленте';

  @override
  String get onboardingTitle2 => 'Проверенные гиды';

  @override
  String get onboardingSubTitle2 =>
      'Читайте честные отзывы от реальных туристов';

  @override
  String get onboardingTitle3 => 'Бронируй в 3 клика';

  @override
  String get onboardingSubTitle3 =>
      'Без долгих переписок, скриншотов и ожидания';

  @override
  String get next => 'Далее';

  @override
  String otpMessage(Object phone) {
    return 'На номер $phone было отправлено 4-значное сообщение OTP';
  }

  @override
  String get selectLang => 'Выберите язык';

  @override
  String get selectTheme => 'Выберите тему';

  @override
  String get lightTheme => 'Светлая тема';

  @override
  String get darkTheme => 'Тёмная тема';

  @override
  String get aboutUs => 'О наc';

  @override
  String get lastUpdate => 'Последнее обновление:';

  @override
  String get contactUs => 'Свяжитесь с нами';

  @override
  String get appDescription =>
      'Это приложение объединяет все предложения по отдыху в Кыргызстане от надежных организаторов.';

  @override
  String get withUsYouGet => 'С нами вы получаете: ';

  @override
  String get timeSavingTitle => 'Экономия времени: ';

  @override
  String get timeSavingDescription =>
      'Все актуальные туры на любую дату теперь собраны в одной удобной ленте. Не тратьте больше часы на поиск в социальных сетях.';

  @override
  String get safetyAndTrustTitle => 'Безопасность и доверие: ';

  @override
  String get safetyAndTrustDescription =>
      'Мы сотрудничаем только с надежными партнерами. Вы можете ознакомиться с честными отзывами и рейтингами перед тем, как сделать выбор.';

  @override
  String get simplicityAndConvenienceTitle => 'Простота и удобство: ';

  @override
  String get simplicityAndConvenienceDescription =>
      'Бронируйте и оплачивайте туры онлайн в приложении за несколько кликов.';

  @override
  String get myTickets => 'Мои билеты';

  @override
  String get appTheme => 'Тема приложения';

  @override
  String get profile => 'Профиль';

  @override
  String get appLanguage => 'Язык приложения';

  @override
  String get shareApp => 'Поделиться';

  @override
  String get logOut => 'Выйти';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get version => 'Версия: ';
}
