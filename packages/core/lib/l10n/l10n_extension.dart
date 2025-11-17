import 'package:core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => Localizations.of<AppLocalizations>(this, AppLocalizations)!;
}
