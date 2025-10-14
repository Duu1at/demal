import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppInputColorExtension extends ThemeExtension<AppInputColorExtension> {
  AppInputColorExtension({
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
    return AppInputColorExtension(
      bckgr: AppColors.white,
      disabled: const Color(0xff9C9FAF),
      focused: const Color(0xff323D76),
      disabledBckgr: const Color(0xff9C9FAF),
      error: const Color(0xffB91C21),
      success: const Color(0xff047857),
    );
  }

  factory AppInputColorExtension.dark() {
    return AppInputColorExtension(
      bckgr: AppColors.gray.shade50,
      disabled: const Color(0xff9C9FAF),
      focused: const Color(0xff323D76),
      disabledBckgr: const Color(0xff9C9FAF),
      error: const Color(0xffB91C21),
      success: const Color(0xff047857),
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
