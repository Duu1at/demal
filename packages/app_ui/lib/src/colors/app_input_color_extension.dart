import 'package:flutter/material.dart';

class AppInputColorExtension extends ThemeExtension<AppInputColorExtension> {
  const AppInputColorExtension({
    this.primary,
    this.background,
    this.focused,
    this.error,
    this.success,
  });

  final Color? primary;
  final Color? background;
  final Color? focused;
  final Color? error;
  final Color? success;

  factory AppInputColorExtension.light() {
    return const AppInputColorExtension(
      primary: Color(0xFF9C9FAF),
      background: Colors.white,
      error: Color(0xFFDC2626),
      success: Color(0xFF16A34A),
    );
  }

  factory AppInputColorExtension.dark() {
    return const AppInputColorExtension(
      primary: Color(0xFF9C9FAF),
      background: Color(0xFF1F2328),
      error: Color(0xFFEF4444),
      success: Color(0xFF22C55E),
    );
  }

  @override
  ThemeExtension<AppInputColorExtension> copyWith({
    Color? primary,
    Color? background,
    Color? focused,
    Color? error,
    Color? success,
  }) {
    return AppInputColorExtension(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      focused: focused ?? this.focused,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  ThemeExtension<AppInputColorExtension> lerp(
    ThemeExtension<AppInputColorExtension>? other,
    double t,
  ) {
    if (other is! AppInputColorExtension) return this;

    return AppInputColorExtension(
      primary: Color.lerp(primary, other.primary, t),
      background: Color.lerp(background, other.background, t),
      focused: Color.lerp(focused, other.focused, t),
      error: Color.lerp(error, other.error, t),
      success: Color.lerp(success, other.success, t),
    );
  }
}

extension AppInputColors on BuildContext {
  AppInputColorExtension get inputColors =>
      Theme.of(this).extension<AppInputColorExtension>()!;
}
