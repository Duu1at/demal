import 'package:app_ui/src/app_ui.dart';
import 'package:flutter/material.dart';

@immutable
final class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl(this.dataSource);
  final AppLocalDataSource dataSource;

  @override
  ThemeMode getInitialThemeState() {
    return dataSource.getInitialThemeMode();
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) {
    return dataSource.saveThemeMode(mode);
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
