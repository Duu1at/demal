abstract final class AppCurrencyFormatter {
  static String cuccancyType(String currancy) {
    return switch (currancy) {
      'KGZ' => 'С',
      'Dollar' => r'$',
      _ => 'C',
    };
  }
}
