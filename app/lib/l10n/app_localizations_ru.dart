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
}
