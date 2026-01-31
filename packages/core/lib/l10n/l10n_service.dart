import 'package:core/l10n/app_localizations.dart';

class L10nService {
  L10nService._();

  static final L10nService _instance = L10nService._();
  static L10nService get instance => _instance;

  AppLocalizations? _localizations;

  AppLocalizations? get localizations => _localizations;

  set localizations(AppLocalizations value) {
    _localizations = value;
  }

  AppLocalizations get current {
    if (_localizations == null) {
      throw Exception(
        'L10nService not initialized. Make sure to set L10nService.instance.localizations '
        'in your app widget.',
      );
    }
    return _localizations!;
  }

  bool get isInitialized => _localizations != null;
}

extension L10nServiceX on L10nService {
  AppLocalizations get l10n => current;
}
