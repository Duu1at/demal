
import 'package:intl/intl.dart';

final class AppCurrencyFormatter {
  const AppCurrencyFormatter._();


  static String cuccancyType(String currancy) {
    return switch (currancy) {
      'KGZ' || '417' => 'С',
      'Dollar' => '\$',
      _ => 'C',
    };
  }

  static final currencyDisplayFormat = NumberFormat('#,##0.00', 'RU');
  static String currencyCash(num value) => currencyDisplayFormat.format(value).replaceAll(',', '.');

  static final currency00Format = NumberFormat('#,##0', 'RU');
  static String currencyDouble00(num value) => currency00Format.format(value);
}
