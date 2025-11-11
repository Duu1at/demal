import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

abstract class AppRepository {
  AppTheme getInitialThemeState();

  Locale getInitialLocale();

  Future<void> saveTheme(bool isDark);

  Future<void> saveLocale(Locale locale);
}
