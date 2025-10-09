import 'package:app_ui/src/colors/app_colors.dart';
import 'package:app_ui/src/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';

class AppLightTheme extends AppTheme {
  @override
  ColorScheme get colorScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryLight,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryLight,
    onSecondary: Colors.black,
    error: AppColors.error700,
    onError: Colors.white,
    surface: AppColors.neutral0,
    onSurface: AppColors.neutral900,
  );

  @override
  TextTheme get textTheme => const TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  ).apply(bodyColor: Colors.black, displayColor: Colors.black);

  @override
  TextTheme get primaryTextTheme => const TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  ).apply(bodyColor: AppColors.text500, displayColor: Colors.black);

  @override
  ThemeData get themeData => ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    primaryTextTheme: primaryTextTheme,
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: colorScheme.onSurface,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    inputDecorationTheme: inputDecorationTheme,
    useMaterial3: true,
  );
}
