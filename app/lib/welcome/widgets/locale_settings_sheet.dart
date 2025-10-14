import 'package:app/app/cubits/app_settings/app_locale_cubit.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleSettingsSheet extends StatelessWidget {
  const LocaleSettingsSheet({super.key});

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ru':
        return 'Русский';
      case 'ky':
        return 'Кыргызча';
      default:
        return locale.languageCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    const supportedLocales = AppLocalizations.supportedLocales;
    final currentLocale = context.read<AppLocaleCubit>().state;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Выберите язык',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            RadioGroup<Locale>(
              groupValue: currentLocale,
              onChanged: (newLocale) async {
                await context.read<AppLocaleCubit>().changeLocale(
                  locale: newLocale ?? supportedLocales.first,
                );
                if (context.mounted) Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < supportedLocales.length; i++) ...[
                    if (i > 0) const DividerHorisontal(),
                    RadioListTile.adaptive(
                      title: Text(
                        _getLanguageName(supportedLocales[i]),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      value: supportedLocales[i],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      tileColor: Theme.of(context).colorScheme.surface,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
