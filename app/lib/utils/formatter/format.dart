import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

@immutable
final class Fmt {

  static final emailregex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static String? phoneHint(String countryCode) {
    if (countryCode.toLowerCase() == 'kg') {
      return '996777070707';
    } else {
      return null;
    }
  }

  static List<TextInputFormatter>? phoneFormat(String countryCode) {
    if (countryCode.toLowerCase() == 'kg') {
      return [
        MaskTextInputFormatter(
          mask: '996#########',
          filter: {'#': RegExp('[0-9]')},
        ),
      ];
    } else {
      return null;
    }
  }
}
