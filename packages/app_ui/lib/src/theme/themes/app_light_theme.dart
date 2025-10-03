import 'package:app_ui/src/colors/app_colors.dart';
import 'package:app_ui/src/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';

class AppLightTheme extends AppTheme {
  @override
  ColorScheme get colorScheme => AppColors.light;

  @override
  TextTheme get textTheme =>
      AppTypography.textTheme.apply(bodyColor: AppColors.neutral900, displayColor: AppColors.neutral900);

  @override
  TextTheme get primaryTextTheme =>
      textTheme.apply(bodyColor: AppColors.neutral900, displayColor: AppColors.neutral900);

  @override
  ThemeData get themeData => ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    primaryTextTheme: primaryTextTheme,
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: colorScheme.onSurface,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    useMaterial3: true,
  );
}
