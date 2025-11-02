class ToursConstants {
  ToursConstants._();

  /// Лимит туров на странице
  static const int tourLimit = 20;

  /// Задержка для throttle (предотвращение слишком частых запросов)
  static const Duration throttleDuration = Duration(milliseconds: 300);

  /// Задержка для debounce (поиск)
  static const Duration debounceDuration = Duration(milliseconds: 500);

  /// Процент скролла для загрузки следующей страницы (90%)
  static const double scrollThreshold = 0.9;
}

