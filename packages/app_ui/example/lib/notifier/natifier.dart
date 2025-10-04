import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

enum MqAppUiType {
  light,
  dark;

  factory MqAppUiType.fromString(String? value) {
    return switch (value) {
      'dark' => MqAppUiType.dark,
      _ => MqAppUiType.light,
    };
  }
}

class MqAppUiNotifier extends ChangeNotifier {
  MqAppUiNotifier(this.storage);

  final PreferencesStorage storage;

  static const _themeKey = 'theme-key';

  MqAppUiType _themeType = MqAppUiType.light;
  MqAppUiType get themeType => _themeType;

  void init() {
    try {
      final value = storage.readString(key: _themeKey);
      _themeType = MqAppUiType.fromString(value);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> changeTheme(MqAppUiType type) async {
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
      MqAppUiType.light => AppLightTheme(),
      MqAppUiType.dark => AppDarkTheme(),
    };
  }
}
