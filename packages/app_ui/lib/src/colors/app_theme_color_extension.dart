import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppThemeColorsExtension extends ThemeExtension<AppThemeColorsExtension> {
  AppThemeColorsExtension({
    this.alert,
    this.alertBackground,
    this.disabled,
    this.disabledForeground,
    this.shimmerBase,
    this.shimmerHighlight,
    this.blueShadow,
    this.grayShadow,
  });

  final Color? alert;
  final Color? alertBackground;
  final Color? disabled;
  final Color? disabledForeground;
  final BoxShadow? blueShadow;
  final BoxShadow? grayShadow;
  final Color? shimmerBase;
  final Color? shimmerHighlight;

  static AppThemeColorsExtension? of(BuildContext context) {
    return Theme.of(context).extension<AppThemeColorsExtension>();
  }

  factory AppThemeColorsExtension.light() {
    return AppThemeColorsExtension(
      alert: AppColors.alert.shade30,
      disabled: AppColors.gray.shade20,
      disabledForeground: AppColors.gray.shade30,
      alertBackground: AppColors.alert.shade10,
      grayShadow: BoxShadow(
        color: AppColors.grayShadow.color!,
        offset: Offset(AppColors.grayShadow.x!, AppColors.grayShadow.y!),
        blurRadius: AppColors.grayShadow.blur!,
        spreadRadius: AppColors.grayShadow.spread!,
      ),
      blueShadow: BoxShadow(
        color: AppColors.blueShadow.color!,
        offset: Offset(AppColors.blueShadow.x!, AppColors.blueShadow.y!),
        blurRadius: AppColors.blueShadow.blur!,
        spreadRadius: AppColors.blueShadow.spread!,
      ),
      shimmerBase: AppColors.lightShimmer.colors.last,
      shimmerHighlight: AppColors.lightShimmer.colors.first,
    );
  }

  factory AppThemeColorsExtension.dark() {
    return AppThemeColorsExtension(
      alert: AppColors.alert.shade30,
      disabled: AppColors.gray.shade20,
      disabledForeground: AppColors.gray.shade30,
      alertBackground: AppColors.alert.shade10,
      grayShadow: BoxShadow(
        color: AppColors.grayShadow.color!,
        offset: Offset(AppColors.grayShadow.x!, AppColors.grayShadow.y!),
        blurRadius: AppColors.grayShadow.blur!,
        spreadRadius: AppColors.grayShadow.spread!,
      ),
      blueShadow: BoxShadow(
        color: AppColors.blueShadow.color!,
        offset: Offset(AppColors.blueShadow.x!, AppColors.blueShadow.y!),
        blurRadius: AppColors.blueShadow.blur!,
        spreadRadius: AppColors.blueShadow.spread!,
      ),
      shimmerBase: AppColors.lightShimmer.colors.last,
      shimmerHighlight: AppColors.lightShimmer.colors.first,
    );
  }

  @override
  ThemeExtension<AppThemeColorsExtension> copyWith({
    Color? alert,
    Color? alertBackground,
    Color? disabled,
    Color? disabledForeground,
    BoxShadow? grayShadow,
    BoxShadow? blueShadow,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return AppThemeColorsExtension(
      alert: alert ?? this.alert,
      alertBackground: alertBackground ?? this.alertBackground,
      disabled: disabled ?? this.disabled,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      grayShadow: grayShadow ?? this.grayShadow,
      blueShadow: blueShadow ?? this.blueShadow,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  ThemeExtension<AppThemeColorsExtension> lerp(
    covariant ThemeExtension<AppThemeColorsExtension>? other,
    double t,
  ) {
    if (other is! AppThemeColorsExtension) {
      return this;
    }
    return AppThemeColorsExtension(
      alert: Color.lerp(alert, other.alert, t),
      disabled: Color.lerp(disabled, other.disabled, t),
      disabledForeground: Color.lerp(
        disabledForeground,
        other.disabledForeground,
        t,
      ),
      alertBackground: Color.lerp(alertBackground, other.alertBackground, t),
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t),
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t),
      blueShadow: BoxShadow.lerp(blueShadow, other.blueShadow, t),
      grayShadow: BoxShadow.lerp(grayShadow, other.grayShadow, t),
    );
  }
}

extension AppColorsExtension on BuildContext {
  AppThemeColorsExtension get appcolors =>
      Theme.of(this).extension<AppThemeColorsExtension>()!;
}
