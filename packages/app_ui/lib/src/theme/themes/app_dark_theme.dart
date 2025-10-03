import 'package:app_ui/src/colors/app_colors.dart';
import 'package:app_ui/src/theme/app_theme.dart';
import 'package:app_ui/src/typography/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppDarkTheme extends AppTheme {
  @override
  ColorScheme get colorScheme => AppColors.dark;

  @override
  TextTheme get textTheme =>
      AppTypography.textTheme.apply(bodyColor: AppColors.neutral0, displayColor: AppColors.neutral300);

  @override
  TextTheme get primaryTextTheme => textTheme.apply(bodyColor: AppColors.neutral0, displayColor: AppColors.neutral300);

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
