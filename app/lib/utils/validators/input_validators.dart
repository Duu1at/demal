import 'package:app/utils/extensions/string_extension.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

abstract final class InputValidators {
  static String? emailValidator(
    BuildContext context,
    String? val, {
    bool canBeGmail = true,
  }) {
    if (val.isNullOrEmpty) return context.l10n.fieldRequired;
    if (val!.isEmail) {
      if (!canBeGmail && val.endsWith('@gmail.com')) return context.l10n.fieldRequired;
      return null;
    }

    return context.l10n.fieldRequired;
  }
}
