import 'package:app_ui/repo/repo.dart';
import 'package:app_ui/theme/theme.dart';
import 'package:flutter/material.dart';

@immutable
final class AppLocalDataSourceMock implements AppLocalDataSource {
  const AppLocalDataSourceMock();

  @override
  Future<void> saveTheme(bool isDark) => Future.value();

  @override
  AppTheme getInitialTheme() => AppLightTheme();

  @override
  Locale getInitialLocale() {
    return const Locale('ru');
  }

  @override
  Future<void> saveLocale(Locale locale) {
    return Future.value();
  }
}
