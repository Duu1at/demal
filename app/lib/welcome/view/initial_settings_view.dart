import 'package:app/app/cubits/app_cubit.dart';
import 'package:app/app/cubits/app_settings/app_theme_cubit.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/welcome/welcome.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
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
    super.initState();
    final isDark = context.read<AppThemeCubit>().state.isDark;
    _themeName = isDark ? 'Темная' : 'Светлая';
  }

  void _changeLocale(BuildContext context) {
    BottomSheets.showModalSettingsSheet(
      backgroundColor: context.appColors.bgCard,
      context: context,
      child: const LocaleSettingsSheet(),
    );
  }

  Future<void> _changeTheme(BuildContext context) async {
    final result =
        await BottomSheets.showModalSettingsSheet(
              backgroundColor: context.appColors.bgCard,
              context: context,
              child: const ThemeSelectorSheet(),
            )
            as bool;
    setState(() {
      _themeName = result ? 'Темная' : 'Светлая';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaffoldWithBgImage(
      bgImageTop: false,
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
            const SizedBox(height: AppSpacing.xxxxlg),
            const RoleSelector(),
            const DividerHorisontal(),
            SettingsList(
              locale: _locale,
              themeName: _themeName,
              onChangeLocale: () => _changeLocale(context),
              onChangeTheme: () => _changeTheme(context),
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

class RoleSelector extends StatelessWidget {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous.role != current.role,
      builder: (context, state) {
        final role = state.role;
        return Column(
          children: [
            RoleRedioWidget(
              key: const Key('client'),
              title: 'Путешественник',
              role: role,
              onChanged: (_) =>
                  context.read<AppCubit>().changeRole(role: Role.client),
            ),
            RoleRedioWidget(
              key: const Key('partner'),
              title: 'Тур компания или гид',
              role: role,
              isClient: false,
              onChanged: (_) =>
                  context.read<AppCubit>().changeRole(role: Role.partner),
            ),
          ],
        );
      },
    );
  }
}

class SettingsList extends StatelessWidget {
  const SettingsList({
    required this.locale,
    required this.themeName,
    required this.onChangeLocale,
    required this.onChangeTheme,
    super.key,
  });

  final String locale;
  final String themeName;
  final VoidCallback onChangeLocale;
  final VoidCallback onChangeTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardDrawerTile(
          icon: const Icon(Icons.language_outlined),
          title: 'Выберите язык',
          subtitle: locale,
          onTap: onChangeLocale,
        ),
        const DividerHorisontal(),
        CardDrawerTile(
          icon: const Icon(Icons.sunny),
          title: 'Выберите тему',
          subtitle: themeName,
          onTap: onChangeTheme,
        ),
      ],
    );
  }
}
