import 'package:flutter/material.dart';

abstract class AppColors {
  // Neutral

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  // static const Color neutral50 = Color(0xFFFAFAFA);
  // static const Color neutral100 = Color(0xFFF5F5F5);
  // static const Color neutral200 = Color(0xFFE0E0E0);
  // static const Color neutral300 = Color(0xFFBDBDBD);
  // static const neutral700 = Color(0xFF424242);
  // static const neutral800 = Color(0xFF303030);
  // static const Color neutral900 = Color(0xFF212121);

  // Primary (пример: твой дизайн → light = #F54749, dark = #345AFA)
  static const Color primaryLight = Color(0xFFF75D37);
  static const Color secondaryLight = Color(0xFFF75D37);

  // Primary dark
  static const Color primaryDark = Color(0xFF345AFA);
  static const Color secondaryDark = Color(0xFF345AFA);

  // Secondary
  static const Color secondary50 = Color(0xFFFCE4EC);
  static const Color secondary700 = Color(0xFFC2185B);
  static const Color secondary900 = Color(0xFF880E4F);

  // Success
  static const Color success50 = Color(0xFFE8F5E9);
  static const Color success700 = Color(0xFF2E7D32);
  static const Color success900 = Color(0xFF1B5E20);

  // Warning
  static const Color warning50 = Color(0xFFFFF3E0);
  static const Color warning700 = Color(0xFFF57C00);
  static const Color warning900 = Color(0xFFE65100);

  // Error
  static const Color error50 = Color(0xFFFFEBEE);
  static const Color error700 = Color(0xFFD32F2F);
  static const Color error900 = Color(0xFFB71C1C);

  // Info
  static const Color info50 = Color(0xFFE3F2FD);
  static const Color info700 = Color(0xFF1976D2);
  static const Color info900 = Color(0xFF0D47A1);

  static const Color transparent = Colors.transparent;

  static const AppColorSwatch blue = AppColorSwatch(0xFF006ae2, {
    0: Color(0xFFe9f3ff),
    10: Color(0xFFafd4ff),
    20: Color(0xFF79b6fc),
    40: Color(0xFF3b93f6),
    50: Color(0xFF156CE6),
    60: Color(0xFF065cbd),
    80: Color(0xFF143F75),
    90: Color(0xFF082345),
  });

  static const AppColorSwatch orange = AppColorSwatch(0xFFF75D37, {
    0: Color(0xFFFFF3E0),
    10: Color(0xFFFFE0B2),
    20: Color(0xFFFFCC80),
    30: Color(0xFFFFB74D),
    40: Color(0xFFFFA726),
    50: Color(0xFFFF9800),
    60: Color(0xFFFB8C00),
    70: Color(0xFFF57C00),
    80: Color(0xFFEF6C00),
    90: Color(0xFFE65100),
  });

  static const AppColorSwatch gray = AppColorSwatch(0xFF2a2f34, {
    0: Color(0xFFf4f6f8),
    10: Color(0xFFe3e8ec),
    20: Color(0xFFc5cdd4),
    30: Color(0xFF8a949e),
    40: Color(0xFF59636d),
    45: Color(0xFF394047),
    47: Color(0xFF292F35),
    50: Color(0xFF1F2328),
    60: Color(0xFF0D1012),
  });

  static const AppColorSwatch yellow = AppColorSwatch(0xFFfebf24, {
    10: Color(0xFFfff9ea),
    20: Color(0xFFfff0cd),
    30: Color(0xFFffe097),
    40: Color(0xFFfed063),
    50: Color(0xFFf4bb34),
  });

  static const AppColorSwatch alert = AppColorSwatch(0xFF009361, {
    10: Color(0xFFfdeced),
    30: Color(0xFFF44B57),
    40: Color(0xFFe73a46),
    80: Color(0xFF60070D),
  });

  static const AppColorSwatch green = AppColorSwatch(0xFF5CE091, {
    10: Color(0xFFE3F9EC),
    30: Color(0xFF5CE091),
    40: Color(0xFF26CA67),
    50: Color(0xFF0EAA4C),
  });

  static const AppShadow grayShadow = AppShadow(
    color: Color(0x0F384a5e),
    x: 0,
    y: 12,
    blur: 16,
    spread: 0,
  );

  static const AppShadow blueShadow = AppShadow(
    color: Color(0x30044084),
    x: 0,
    y: 12,
    blur: 16,
    spread: 0,
  );

  static LinearGradient lightShimmer = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF4F6F8), Color(0xFFE0E6Ed)],
  );

  static LinearGradient darkShimmer = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF293036), Color(0xFF4D5761)],
  );
}

class AppColorSwatch extends ColorSwatch<int> {
  const AppColorSwatch(super.primary, super.swatch);

  Color? get shade0 => this[0];
  Color? get shade10 => this[10];
  Color? get shade20 => this[20];
  Color? get shade30 => this[30];
  Color? get shade40 => this[40];
  Color? get shade45 => this[45];
  Color? get shade47 => this[47];
  Color? get shade50 => this[50];
  Color? get shade60 => this[60];
  Color? get shade70 => this[70];
  Color? get shade80 => this[80];
  Color? get shade90 => this[90];
}

class AppShadow {
  final Color? color;
  final double? x;
  final double? y;
  final double? blur;
  final double? spread;

  const AppShadow({this.blur, this.color, this.spread, this.x, this.y});
}
