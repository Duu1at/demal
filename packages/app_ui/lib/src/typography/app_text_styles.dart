import 'package:flutter/material.dart';
import 'app_font_weight.dart';

abstract class AppTypography {
  static const String fontFamily = 'Roboto'; // Замени на свой шрифт

  static const TextStyle heading1 = TextStyle(fontSize: 40, height: 45 / 40, fontWeight: AppFontWeight.bold);

  static const TextStyle heading2 = TextStyle(fontSize: 32, height: 37 / 32, fontWeight: AppFontWeight.bold);

  static const TextStyle heading3 = TextStyle(fontSize: 28, height: 33 / 28, fontWeight: AppFontWeight.bold);

  static const TextStyle heading4 = TextStyle(fontSize: 24, height: 29 / 24, fontWeight: AppFontWeight.bold);

  static const TextStyle heading5 = TextStyle(fontSize: 20, height: 25 / 20, fontWeight: AppFontWeight.bold);

  static const TextStyle buttonText = TextStyle(fontSize: 17, height: 22 / 17, fontWeight: AppFontWeight.medium);

  static const TextStyle bodyLargeBold = TextStyle(fontSize: 17, height: 22 / 17, fontWeight: AppFontWeight.bold);

  static const TextStyle bodyLargeMedium = TextStyle(fontSize: 17, height: 22 / 17, fontWeight: AppFontWeight.medium);

  static const TextStyle bodyLargeRegular = TextStyle(fontSize: 17, height: 22 / 17, fontWeight: AppFontWeight.regular);

  static const TextStyle bodyBold = TextStyle(fontSize: 15, height: 20 / 15, fontWeight: AppFontWeight.bold);

  static const TextStyle bodyMedium = TextStyle(fontSize: 15, height: 20 / 15, fontWeight: AppFontWeight.medium);

  static const TextStyle bodyRegular = TextStyle(fontSize: 15, height: 20 / 15, fontWeight: AppFontWeight.regular);

  static const TextStyle bodySmallBold = TextStyle(fontSize: 13, height: 18 / 13, fontWeight: AppFontWeight.bold);

  static const TextStyle bodySmallMedium = TextStyle(fontSize: 13, height: 18 / 13, fontWeight: AppFontWeight.medium);

  static const TextStyle bodySmallRegular = TextStyle(fontSize: 13, height: 18 / 13, fontWeight: AppFontWeight.regular);

  static const TextStyle captionMedium = TextStyle(fontSize: 11, height: 13 / 11, fontWeight: AppFontWeight.medium);

  static const TextStyle captionRegular = TextStyle(fontSize: 11, height: 13 / 11, fontWeight: AppFontWeight.regular);

  /// Полный `TextTheme`
  static const TextTheme textTheme = TextTheme(
    displayLarge: heading1,
    displayMedium: heading2,
    displaySmall: heading3,
    headlineMedium: heading4,
    headlineSmall: heading5,
    labelLarge: buttonText,
    bodyLarge: bodyLargeRegular,
    bodyMedium: bodyRegular,
    bodySmall: bodySmallRegular,
    labelMedium: captionMedium,
    labelSmall: captionRegular,
  );
}
