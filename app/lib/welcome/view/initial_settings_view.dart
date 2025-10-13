import 'package:app/app/cubit/app_cubit.dart';
import 'package:app/core/core.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/welcome/welcome.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InitialSettingsView extends StatefulWidget {
  const InitialSettingsView({super.key});

  @override
  State<InitialSettingsView> createState() => _InitialSettingsViewState();
}

class _InitialSettingsViewState extends State<InitialSettingsView> {
  String get _locale => AppLocalizations.of(context).localeName;
  String _themeName = '';

  @override
  void initState() {
    _themeName = context.read<AppCubit>().state.theme.isDark
        ? 'Темная'
        : 'Светлая';
    super.initState();
  }

  void _changeLocale(BuildContext context) {
    BottomSheets.showModalSettingsSheet(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      context: context,
      child: const LocaleSettingsSheet(),
    );
  }

  void _changeTheme(BuildContext context) async {
    final result =
        await BottomSheets.showModalSettingsSheet(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              context: context,
              child: const ThemeSelectorSheet(),
            )
            as bool;
    _themeName = result ? 'Темная' : 'Светлая';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: [
            Text('Добро пожаловать!', style: theme.textTheme.headlineLarge),
            Text(
              'Настраивайте настройки приложения',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Text('Выберите роль', style: theme.textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.sm),
            RoleRedioWidget(
              key: const Key('client'),
              title: 'Путешественник',
              role: context.watch<AppCubit>().state.role,
              onChanged: (value) {
                context.read<AppCubit>().changeRole(role: Role.client);
              },
            ),
            RoleRedioWidget(
              key: const Key('partner'),
              title: 'Тур компания или гид',
              role: context.watch<AppCubit>().state.role,
              isClient: false,
              onChanged: (value) {
                context.read<AppCubit>().changeRole(role: Role.partner);
              },
            ),
            const DividerHorisontal(),
            DrawerTile(
              icon: const Icon(Icons.language_outlined),
              title: 'Выберите язык',
              subtitle: _locale,
              onTap: () => _changeLocale(context),
            ),
            const DividerHorisontal(),
            DrawerTile(
              icon: const Icon(Icons.sunny),
              title: 'Выберите тему',
              subtitle: _themeName,
              onTap: () => _changeTheme(context),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: const Text('Начать'),
        onPressed: () => context.goNamed(AppRouter.onboardingOne),
      ),
    );
  }
}
