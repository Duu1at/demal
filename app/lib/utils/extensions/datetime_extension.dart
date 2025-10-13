extension DateTimeX on DateTime {
  DateTime get days7 => subtract(const Duration(days: 7));
  DateTime get days30 => subtract(const Duration(days: 30));
}

extension DateTimeXNullable on DateTime? {
  String get dtStr {
    if (this == null) return '';
    return '${this!.day > 9 ? this!.day : '0${this!.day}'}.${this!.month > 9 ? this!.month : '0${this!.month}'}.${this!.year}';
  }

  String get timeStr {
    if (this == null) return '';
    return '${this!.hour > 9 ? this!.hour : '0${this!.hour}'}:${this!.minute > 9 ? this!.minute : '0${this!.minute}'}:${this!.second > 9 ? this!.second : '0${this!.second}'}';
  }
}
