import 'package:app/utils/extensions/string_extension.dart';

abstract final class InputValidators {
  static String? emailValidator(
    String? val, {
    bool canBeGmail = true,
  }) {
    if (val.isNullOrEmpty) return 'Поле обязательно для заполнения';
    if (val!.isEmail) {
      if (!canBeGmail && val.endsWith('@gmail.com')) return 'Поле обязательно для заполнения';
      return null;
    }

    return 'Поле обязательно для заполнения';
  }
}
