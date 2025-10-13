import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app/cubit/app_cubit.dart';
import 'package:app_ui/app_ui.dart';

class ThemeSelectorSheet extends StatelessWidget {
  const ThemeSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final appState = context.watch<AppCubit>().state;
    final bool isDark = appState.theme is AppDarkTheme;

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
              'Выберите тему',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            RadioGroup<bool>(
              groupValue: isDark,
              onChanged: (newValue) async {
                await appCubit.changeMode(isDark: newValue ?? false);
                if (context.mounted) Navigator.pop(context, newValue);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile.adaptive(
                      title: Text(
                        'Светлая тема',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      value: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      tileColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh,
                    ),
                    const DividerHorisontal(),
                    RadioListTile.adaptive(
                      title: Text(
                        'Тёмная тема',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      value: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                      ),
                      tileColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
