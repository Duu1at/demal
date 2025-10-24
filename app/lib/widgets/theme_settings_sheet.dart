import 'package:app/app/cubits/app_settings/app_theme_cubit.dart';
import 'package:app/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_ui/app_ui.dart';

class ThemeSelectorSheet extends StatelessWidget {
  const ThemeSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<AppThemeCubit>().state is AppDarkTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.selectTheme,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            RadioGroup<bool>(
              groupValue: isDark,
              onChanged: (newValue) async {
                await context.read<AppThemeCubit>().changeMode(
                  isDark: newValue ?? false,
                );
                if (context.mounted) Navigator.pop(context, newValue);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile.adaptive(
                    title: Text(
                      context.l10n.lightTheme,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    value: false,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    tileColor: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  const DividerHorisontal(),
                  RadioListTile.adaptive(
                    title: Text(
                      context.l10n.darkTheme,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    value: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    tileColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHigh,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
