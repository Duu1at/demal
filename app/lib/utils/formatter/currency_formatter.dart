import 'package:tour_repository/tour_repository.dart';

abstract final class AppCurrencyFormatter {
  static String cuccancyType(Currency currency) {
    return switch (currency) {
      Currency.KGS => 'С',
      Currency.USD => r'$',
      Currency.RUB => 'R',
    };
  }
}
