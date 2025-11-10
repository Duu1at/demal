extension DateTimeX on DateTime {
  DateTime get days7 => subtract(const Duration(days: 7));
  DateTime get days30 => subtract(const Duration(days: 30));
}
