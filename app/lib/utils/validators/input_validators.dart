import './../extensions/string_extension.dart';

final class InputValidators {
  const InputValidators._();

  // static String? phoneValidator(String? val) {
  //   return val.isNullOrEmpty
  //       ? 'Поле обязательно для заполнения'
  //       : val!.length < 13
  //       ? 'Введите корректный номер телефона'
  //       : null;
  // }

  // static String? phoneValidatorWith996(String? val) {
  //   return val.isNullOrEmpty
  //       ? 'Поле обязательно для заполнения'
  //       : val!.length != 18
  //       ? 'Введите корректный номер телефона'
  //       : null;
  // }

  static String? phoneValidatorWithout996(String? val) {
    if (val.isNullOrEmpty) return 'Поле обязательно для заполнения';

    final digitsOnly = val!.replaceAll(RegExp(r'\D'), '');

    return digitsOnly.length != 9 ? 'Введите корректный номер телефона' : null;
  }
}
