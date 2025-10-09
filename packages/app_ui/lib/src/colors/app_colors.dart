import 'package:flutter/material.dart';

abstract class AppColors {
  // Neutral
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE0E0E0);
  static const Color neutral300 = Color(0xFFBDBDBD);
  static const neutral700 = Color(0xFF424242);
  static const neutral800 = Color(0xFF303030);
  static const Color neutral900 = Color(0xFF212121);

  // Primary (пример: твой дизайн → light = #F54749, dark = #345AFA)
  static const Color primaryLight = Color(0xFFF75D37);
  static const Color secondaryLight = Color(0xFFF75D37);

  // Primary dark
  static const Color primaryDark = Color(0xFF345AFA);
  static const Color secondaryDark = Color(0xFF345AFA);

  // Secondary
  static const Color secondary50 = Color(0xFFFCE4EC);
  static const Color secondary700 = Color(0xFFC2185B);
  static const Color secondary900 = Color(0xFF880E4F);

  // Success
  static const Color success50 = Color(0xFFE8F5E9);
  static const Color success700 = Color(0xFF2E7D32);
  static const Color success900 = Color(0xFF1B5E20);

  // Warning
  static const Color warning50 = Color(0xFFFFF3E0);
  static const Color warning700 = Color(0xFFF57C00);
  static const Color warning900 = Color(0xFFE65100);

  // Error
  static const Color error50 = Color(0xFFFFEBEE);
  static const Color error700 = Color(0xFFD32F2F);
  static const Color error900 = Color(0xFFB71C1C);

  // Info
  static const Color info50 = Color(0xFFE3F2FD);
  static const Color info700 = Color(0xFF1976D2);
  static const Color info900 = Color(0xFF0D47A1);

  // Text & Icon
  static const Color text900 = Color(0xFF212121); // strong
  static const Color text600 = Color(0xFF424242); // default
  static const Color text500 = Color(0xFF616161); // weak
  static const Color text400 = Color(0xFF9E9E9E); // weaker
  static const Color text300 = Color(0xFFE0E0E0); // disabled
  static const Color text0 = Color(0xFFFFFFFF); // button

  static const Color transparent = Colors.transparent;
}

extension AppStateColors on ColorScheme {
  Color get borderNormal => brightness == Brightness.light
      ? const Color(0xff9C9FAF)
      : AppColors.neutral700;

  Color get enubled => brightness == Brightness.light
      ? const Color(0xffE5E6EB)
      : AppColors.neutral700;

  Color get borderFocused =>
      brightness == Brightness.light ? primary : primaryContainer;

  Color get borderError =>
      brightness == Brightness.light ? AppColors.error700 : AppColors.error700;

  Color get borderErrorFocused => AppColors.error900;

  Color get borderSuccess => AppColors.success700;

  Color get borderDisabled => brightness == Brightness.light
      ? AppColors.neutral200
      : AppColors.neutral800;
}
