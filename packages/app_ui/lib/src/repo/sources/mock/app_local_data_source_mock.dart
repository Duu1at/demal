import 'package:app_ui/src/repo/repo.dart';
import 'package:flutter/material.dart';

@immutable
final class AppLocalDataSourceMock implements AppLocalDataSource {
  const AppLocalDataSourceMock();

  @override
  Future<void> saveThemeMode(ThemeMode mode) => Future.value();

  @override
  ThemeMode getInitialThemeMode() => ThemeMode.system;

  @override
  Locale getInitialLocale() {
    return const Locale('ru');
  }

  @override
  Future<void> saveLocale(Locale locale) {
    return Future.value();
  }
}
