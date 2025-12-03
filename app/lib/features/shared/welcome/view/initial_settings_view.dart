import 'package:app/app/cubits/app_theme_cubit/app_theme_cubit.dart';
import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/app/mixin/settings_change_mixin.dart';
import 'package:app/app/router/app_router.dart';
import 'package:app/features/shared/welcome/widgets/role_radio_group.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InitialSettingsView extends StatefulWidget {
  const InitialSettingsView({super.key});

  @override
  State<InitialSettingsView> createState() => _InitialSettingsViewState();
}

class _InitialSettingsViewState extends State<InitialSettingsView> with SettingsChangeMixin<InitialSettingsView> {
  String get _locale => AppLocalizations.of(context).localeName;
  String get _lightTheme => context.l10n.lightTheme;
  String get _darkTheme => context.l10n.darkTheme;
  String _themeName = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isDark = context.read<AppThemeCubit>().state.isDark;
    _themeName = isDark ? _lightTheme : _darkTheme;
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
            const SizedBox(height: AppSpacing.xxxxlg),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (previous, current) => previous.role != current.role,
              builder: (context, state) {
                final role = state.role;
                return RoleRadioGroup(
                  groupValue: role,
                  onChanged: (newRole) {
                    context.read<AuthCubit>().changeRole(newRole ?? RoleEnum.CLIENT);
                  },
                );
              },
            ),
            const DividerHorisontal(),
            CardDrawerWithSubtitle(
              icon: const Icon(Icons.language_outlined),
              title: context.l10n.selectLang,
              subtitle: _locale,
              onTap: changeLocale,
            ),
            const DividerHorisontal(),
            CardDrawerWithSubtitle(
              icon: const Icon(Icons.sunny),
              title: context.l10n.selectTheme,
              subtitle: _themeName,
              onTap: () async {
                final resultIsDark = await changeTheme() ?? false;
                if (mounted) {
                  setState(() => _themeName = resultIsDark ? context.l10n.darkTheme : context.l10n.lightTheme);
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final role = state.role;
          return AppButton(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            onPressed: (role != null)
                ? () {
                    context.goNamed(AppRoutes.onboardingOne);
                  }
                : null,
            child: const Text('Начать'),
          );
        },
      ),
    );
  }
}
