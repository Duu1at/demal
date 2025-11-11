import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

@immutable
final class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl(this.dataSource);
  final AppLocalDataSource dataSource;

  @override
  AppTheme getInitialThemeState() {
    return dataSource.getInitialTheme();
  }

  @override
  Future<void> saveTheme(bool isDark) {
    return dataSource.saveTheme(isDark);
  }

  @override
  Locale getInitialLocale() {
    return dataSource.getInitialLocale();
  }

  @override
  Future<void> saveLocale(Locale locale) {
    return dataSource.saveLocale(locale);
  }
}
