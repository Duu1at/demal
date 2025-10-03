import 'package:flutter/material.dart';

abstract class AppLocalDataSource {
  ThemeMode getInitialThemeMode();

  Future<void> saveThemeMode(ThemeMode mode);

  Locale getInitialLocale();

  Future<void> saveLocale(Locale locale);
}
