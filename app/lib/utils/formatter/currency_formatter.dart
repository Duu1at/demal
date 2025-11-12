final class AppCurrencyFormatter {
  const AppCurrencyFormatter._();

  static String cuccancyType(String currancy) {
    return switch (currancy) {
      'KGZ' => 'С',
      'Dollar' => r'$',
      _ => 'C',
    };
  }
}
