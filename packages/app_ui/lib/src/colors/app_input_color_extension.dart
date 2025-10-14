import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppInputColorExtension extends ThemeExtension<AppInputColorExtension> {
  final Color? accent;
  final Color? primary;
  final Color? secondary;
  final Color? alert;
  final Color? bckgr;
  final Color? secondaryBckgr;
  final Color? disabled;
  final Color? pressed;
  final Color? activeSecondary;

  AppInputColorExtension({
    this.accent,
    this.activeSecondary,
    this.alert,
    this.bckgr,
    this.disabled,
    this.pressed,
    this.primary,
    this.secondary,
    this.secondaryBckgr,
  });

  factory AppInputColorExtension.light() {
    return AppInputColorExtension(
      accent: AppColors.blue.shade50,
      activeSecondary: AppColors.blue.shade20,
      alert: AppColors.alert.shade40,
      bckgr: AppColors.white,
      disabled: AppColors.gray.shade30,
      primary: AppColors.gray.shade50,
      pressed: AppColors.gray.shade20,
      secondary: AppColors.gray.shade40,
      secondaryBckgr: AppColors.gray.shade10,
    );
  }

  factory AppInputColorExtension.dark() {
    return AppInputColorExtension(
      accent: AppColors.orange.shade50,
      activeSecondary: AppColors.orange.shade60,
      alert: AppColors.alert.shade40,
      bckgr: AppColors.gray.shade50,
      disabled: AppColors.gray.shade40,
      primary: AppColors.gray.shade0,
      pressed: AppColors.gray.shade30,
      secondary: AppColors.gray.shade20,
      secondaryBckgr: AppColors.gray.shade45,
    );
  }

  @override
  ThemeExtension<AppInputColorExtension> copyWith({
    Color? accent,
    Color? primary,
    Color? secondary,
    Color? alert,
    Color? bckgr,
    Color? secondaryBckgr,
    Color? disabled,
    Color? pressed,
    Color? activeSecondary,
  }) {
    return AppInputColorExtension(
      accent: accent ?? this.accent,
      activeSecondary: activeSecondary ?? this.activeSecondary,
      alert: alert ?? this.alert,
      bckgr: bckgr ?? this.bckgr,
      disabled: disabled ?? this.disabled,
      pressed: pressed ?? this.pressed,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      secondaryBckgr: secondaryBckgr ?? this.secondaryBckgr,
    );
  }

  @override
  ThemeExtension<AppInputColorExtension> lerp(
    AppInputColorExtension? other,
    double t,
  ) {
    if (other is! AppInputColorExtension) {
      return this;
    }
    return AppInputColorExtension(
      accent: Color.lerp(accent, other.accent, t),
      activeSecondary: Color.lerp(activeSecondary, other.activeSecondary, t),
      alert: Color.lerp(alert, other.alert, t),
      bckgr: Color.lerp(bckgr, other.bckgr, t),
      disabled: Color.lerp(disabled, other.disabled, t),
      pressed: Color.lerp(pressed, other.pressed, t),
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      secondaryBckgr: Color.lerp(secondaryBckgr, other.secondaryBckgr, t),
    );
  }
}
