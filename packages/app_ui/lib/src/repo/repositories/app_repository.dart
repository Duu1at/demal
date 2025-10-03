import 'package:flutter/material.dart';

abstract class AppRepository {
  ThemeMode getInitialThemeState();

  Locale getInitialLocale();

  Future<void> saveThemeMode(ThemeMode mode);

  Future<void> saveLocale(Locale locale);
}
