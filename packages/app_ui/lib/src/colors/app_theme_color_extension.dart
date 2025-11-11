import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppThemeColorExtension extends ThemeExtension<AppThemeColorExtension> {
  const AppThemeColorExtension({
    this.bgCard,
    this.alert,
    this.alertBackground,
    this.disabled,
    this.disabledForeground,
    this.shimmerBase,
    this.shimmerHighlight,
    this.blueShadow,
    this.grayShadow,
    this.textSecondary,
  });

  factory AppThemeColorExtension.dark() {
    return AppThemeColorExtension(
      bgCard: AppColors.gray.shade50,
      alert: AppColors.red.shade90,
      disabled: AppColors.gray.shade20,
      disabledForeground: AppColors.gray.shade30,
      alertBackground: AppColors.red.shade10,
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
      textSecondary: AppColors.gray.shade30,
    );
  }

  factory AppThemeColorExtension.light() {
    return AppThemeColorExtension(
      bgCard: AppColors.white,
      alert: AppColors.red.shade90,
      disabled: AppColors.gray.shade20,
      disabledForeground: AppColors.gray.shade30,
      alertBackground: AppColors.red.shade10,
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
      textSecondary: AppColors.gray.shade50,
    );
  }
  final Color? bgCard;
  final Color? alert;
  final Color? alertBackground;
  final Color? disabled;
  final Color? disabledForeground;
  final BoxShadow? blueShadow;
  final BoxShadow? grayShadow;
  final Color? shimmerBase;
  final Color? shimmerHighlight;
  final Color? textSecondary;

  @override
  ThemeExtension<AppThemeColorExtension> copyWith({
    Color? alert,
    Color? alertBackground,
    Color? disabled,
    Color? disabledForeground,
    BoxShadow? grayShadow,
    BoxShadow? blueShadow,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? textSecondary,
  }) {
    return AppThemeColorExtension(
      alert: alert ?? this.alert,
      alertBackground: alertBackground ?? this.alertBackground,
      disabled: disabled ?? this.disabled,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      grayShadow: grayShadow ?? this.grayShadow,
      blueShadow: blueShadow ?? this.blueShadow,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  ThemeExtension<AppThemeColorExtension> lerp(
    covariant ThemeExtension<AppThemeColorExtension>? other,
    double t,
  ) {
    if (other is! AppThemeColorExtension) {
      return this;
    }
    return AppThemeColorExtension(
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
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t),
    );
  }
}

extension AppThemeColorExtensionX on BuildContext {
  AppThemeColorExtension get appColors {
    final colors = Theme.of(this).extension<AppThemeColorExtension>();
    assert(colors != null, 'AppThemeColorExtension not found in ThemeData');
    return colors!;
  }
}
