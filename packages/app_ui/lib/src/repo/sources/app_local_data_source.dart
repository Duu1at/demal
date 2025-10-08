import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

abstract class AppLocalDataSource {
  AppTheme getInitialTheme();

  Future<void> saveTheme(bool isDark);

  Locale getInitialLocale();

  Future<void> saveLocale(Locale locale);
}
