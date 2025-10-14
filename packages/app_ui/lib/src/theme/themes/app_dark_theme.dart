import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppDarkTheme extends AppTheme {
  @override
  ColorScheme get colorScheme => ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.blue,
    onPrimary: AppColors.white,
    secondary: AppColors.blue,
    onSecondary: AppColors.white,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.gray.shade60 ?? Colors.grey.shade900,
    onSurface: AppColors.white,
  );

  @override
  TextTheme get textTheme =>
      const TextTheme(
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
      ).apply(
        bodyColor: AppColors.gray.shade0,
        displayColor: AppColors.gray.shade0,
        decorationColor: AppColors.gray.shade0,
      );

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
  ).apply(bodyColor: AppColors.white, displayColor: const Color(0xFFBDBDBD));

  @override
  ThemeData get themeData => ThemeData(
    primaryColor: AppColors.gray.shade0,
    colorScheme: colorScheme,
    textTheme: textTheme,
    splashFactory: InkSparkle.splashFactory,
    primaryTextTheme: primaryTextTheme,
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: colorScheme.onSurface,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    useMaterial3: true,
    extensions: <ThemeExtension<dynamic>>[
       AppThemeColorExtension.dark(),
      AppInputColorExtension.dark(),
    ],
  );
}
