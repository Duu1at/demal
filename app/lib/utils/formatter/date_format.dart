import 'package:intl/intl.dart';

final class AppDateFormats {
  const AppDateFormats._();

  static final DateFormat formatDdMMYyyy = DateFormat('dd.MM.yyyy');
  static final DateFormat formatDdMMYyyyHHmm = DateFormat('dd.MM.yyyy HH:mm');
  static final DateFormat ddMMyyyHHmmSS = DateFormat('dd.MM.yyyy HH:mm:SS');
  static final DateFormat formatyyyyMMDd = DateFormat('yyyy-MM-dd');
  static final DateFormat formatyyyyMMDdHHmm = DateFormat('yyyy.MM.dd HH:mm');
  static final DateFormat formatDdMM = DateFormat('dd.MM');
  static final DateFormat formatyMMMM = DateFormat.yMMMM('ru');
}
