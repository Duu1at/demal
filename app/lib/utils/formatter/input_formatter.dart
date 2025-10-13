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
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static final phoneFormatterZero = MaskTextInputFormatter(
    mask: '#### ## ## ##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static final dateFormatter = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static final phoneFormatterWith996 = MaskTextInputFormatter(
    mask: '+996 (###) ###-###',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static final cardFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  static String formatBankAccount(String accountNumber) {
    final regex = RegExp(r'(\d{4})(?=\d)');
    return accountNumber.replaceAllMapped(regex, (match) => '${match.group(1)} ');
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  final RegExp _regex = RegExp(r'[+-]?\d+(,\d+)?|[+-]?\d+(\.\d+)?');
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.trim();
    if (newText.isEmpty || _regex.hasMatch(newText)) {
      return newValue;
    }
    return oldValue;
  }
}

class CustomNumberInputFormatter extends TextInputFormatter {
  final int maxIntegerLength;
  final int maxDecimalLength;

  CustomNumberInputFormatter({
    required this.maxIntegerLength,
    required this.maxDecimalLength,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final parts = text.split('.');
    if (parts[0].length > maxIntegerLength) {
      return oldValue;
    }
    if (parts.length > 1 && parts[1].length > maxDecimalLength) {
      return oldValue;
    }

    return newValue;
  }
}
