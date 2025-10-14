import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppInputColorExtension extends ThemeExtension<AppInputColorExtension> {
  const AppInputColorExtension({
    this.bckgr,
    this.disabled,
    this.focused,
    this.disabledBckgr,
    this.error,
    this.success,
  });
  final Color? disabled;
  final Color? focused;
  final Color? disabledBckgr;
  final Color? error;
  final Color? bckgr;
  final Color? success;

  factory AppInputColorExtension.light() {
    return const AppInputColorExtension(
      bckgr: AppColors.white,
      disabled: Color(0xff9C9FAF),
      focused: Color(0xff323D76),
      disabledBckgr: Color(0xff9C9FAF),
      error: Color(0xffB91C21),
      success: Color(0xff047857),
    );
  }

  factory AppInputColorExtension.dark() {
    return const AppInputColorExtension(
      bckgr: Color(0xFF1F2328),
      disabled: Color(0xff9C9FAF),
      focused: Color(0xff323D76),
      disabledBckgr: Color(0xff9C9FAF),
      error: Color(0xffB91C21),
      success: Color(0xff047857),
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
      bckgr: bckgr ?? this.bckgr,
      disabled: disabled ?? this.disabled,
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
      bckgr: Color.lerp(bckgr, other.bckgr, t),
      disabled: Color.lerp(disabled, other.disabled, t),
    );
  }
}

extension AppColorsExtension on BuildContext {
  AppInputColorExtension get inputcolors =>
      Theme.of(this).extension<AppInputColorExtension>()!;
}
