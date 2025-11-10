import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

@immutable
final class AppLocalDataSourceImpl implements AppLocalDataSource {
  const AppLocalDataSourceImpl({required this.storage});

  final PreferencesStorage storage;

  static const _themeKey = 'theme_mode';
  static const _localeKey = 'locale_key';

  @override
  AppTheme getInitialTheme() {
    final value = storage.readString(key: _themeKey);
    switch (value) {
      case 'light':
        return AppLightTheme();
      case 'dark':
        return AppDarkTheme();
      default:
        return AppLightTheme();
    }
  }

  @override
  Future<void> saveTheme(bool isDark) async {
    await storage.writeString(key: _themeKey, value: isDark ? 'dark' : 'light');
  }

  @override
  Locale getInitialLocale() {
    final locale = storage.readString(key: _localeKey);
    switch (locale) {
      case 'ky':
        return const Locale('ky');
      case 'ru':
        return const Locale('ru');
      case 'en':
        return const Locale('en');
      default:
        return const Locale('en');
    }
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await storage.writeString(key: _localeKey, value: locale.languageCode);
  }
}
