import 'package:flutter/material.dart';

class AppShadowsExtension extends ThemeExtension<AppShadowsExtension> {
  final List<BoxShadow> cardShadow;
  final List<BoxShadow> elevationShadow;

  AppShadowsExtension({
    required this.cardShadow,
    required this.elevationShadow,
  });

  @override
  ThemeExtension<AppShadowsExtension> copyWith({
    List<BoxShadow>? cardShadow,
    List<BoxShadow>? elevationShadow,
  }) {
    return AppShadowsExtension(
      cardShadow: cardShadow ?? this.cardShadow,
      elevationShadow: elevationShadow ?? this.elevationShadow,
    );
  }

  @override
  AppShadowsExtension lerp(
    covariant ThemeExtension<AppShadowsExtension>? other,
    double t,
  ) {
    if (other is! AppShadowsExtension) return this;
    return AppShadowsExtension(
      cardShadow: BoxShadow.lerpList(cardShadow, other.cardShadow, t)!,
      elevationShadow: BoxShadow.lerpList(
        elevationShadow,
        other.elevationShadow,
        t,
      )!,
    );
  }
}
