import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

enum AppUiType {
  light,
  dark;

  factory AppUiType.fromString(String? value) {
    return switch (value) {
      'dark' => AppUiType.dark,
      _ => AppUiType.light,
    };
  }
}

class AppUiNotifier extends ChangeNotifier {
  AppUiNotifier(this.storage);

  final PreferencesStorage storage;

  static const _themeKey = 'theme-key';

  AppUiType _themeType = AppUiType.light;
  AppUiType get themeType => _themeType;

  void init() {
    try {
      final value = storage.readString(key: _themeKey);
      _themeType = AppUiType.fromString(value);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> changeTheme(AppUiType type) async {
    try {
      _themeType = type;
      await storage.writeString(key: _themeKey, value: _themeType.name);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  AppTheme get theme {
    return switch (_themeType) {
      AppUiType.light => AppLightTheme(),
      AppUiType.dark => AppDarkTheme(),
    };
  }
}
