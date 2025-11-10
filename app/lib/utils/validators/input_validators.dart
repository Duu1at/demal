import 'package:app/utils/extensions/string_extension.dart';

abstract final class InputValidators {
  static String? phoneValidatorWithout996(String? val) {
    if (val.isNullOrEmpty) return 'Поле обязательно для заполнения';

    final digitsOnly = val!.replaceAll(RegExp(r'\D'), '');

    return digitsOnly.length != 9 ? 'Введите корректный номер телефона' : null;
  }
}
