import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

extension SnackBarContextExtension on BuildContext {
  void showFeatureInDevelopment() {
    AppSnackbar.showInfo(
      context: this,
      title: l10n.comingSoonTitle,
      message: l10n.featureInDevelopmentMessage,
    );
  }
}
