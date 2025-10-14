import 'package:app_ui/src/colors/app_colors.dart';
import 'package:app_ui/src/colors/app_input_color_extension.dart';
import 'package:app_ui/src/colors/app_theme_color_extension.dart';
import 'package:app_ui/src/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';

class AppLightTheme extends AppTheme {
  @override
  ColorScheme get colorScheme =>  ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryLight,
    onPrimary: AppColors.white,
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.black,
    error: AppColors.error700,
    onError: AppColors.white,
    surface: AppColors.gray.shade0?? AppColors.white,
    onSurface: AppColors.black,
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
        bodyColor: AppColors.gray.shade50,
        displayColor: AppColors.gray.shade50,
        decorationColor: AppColors.gray.shade50,
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
  ).apply(bodyColor: AppColors.black, displayColor: AppColors.gray.shade80);

  @override
  ThemeData get themeData => ThemeData(
    primaryColor: AppColors.gray.shade0,
    colorScheme: colorScheme,
    splashFactory: InkSparkle.splashFactory,
    textTheme: textTheme,
    primaryTextTheme: primaryTextTheme,
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: colorScheme.onSurface,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    // inputDecorationTheme: inputDecorationTheme,
    extensions: <ThemeExtension<dynamic>>[
      AppThemeColorsExtension.light(),
      AppInputColorExtension.dark(),
    ],
    useMaterial3: true,
  );
}
