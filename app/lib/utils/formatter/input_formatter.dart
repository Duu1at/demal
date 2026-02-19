import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract final class InputFormatters {
  static final amountFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^\d+[.,]?\d{0,2}'),
  );

  static final phoneFormatter = MaskTextInputFormatter(
    mask: '996 (###) ###-###',
    filter: {'#': RegExp('[0-9]')},
  );

  static String formatPhone(String rawPhone) {
    return phoneFormatter
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: rawPhone),
        )
        .text;
  }

  static final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {'#': RegExp('[0-9]')},
  );
}
