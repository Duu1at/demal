import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final class InputFormatters {
  const InputFormatters._();

  static final amountFormatter = FilteringTextInputFormatter.allow(
    // RegExp(r'^\d+\.?\d{0,2}'),
    RegExp(r'^\d+[.,]?\d{0,2}'),
  );

  static final phoneFormatter = MaskTextInputFormatter(
    mask: '(###) ###-###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static String formatPhone(String rawPhone) {
    return phoneFormatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: rawPhone),
    ).text;
  }

  static final phoneFormatterZero = MaskTextInputFormatter(
    mask: '#### ## ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static final dateFormatter = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static final phoneFormatterWith996 = MaskTextInputFormatter(
    mask: '+996 (###) ###-###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static final cardFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {'#': RegExp(r'[0-9]')},
  );
}

