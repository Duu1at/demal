import 'package:app/app/app.dart';
import 'package:app/utils/utils.dart';
import 'package:core/core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SettingsChangeMixin<SettingsView> {
  late AuthState _authState;
  @override
  void initState() {
    super.initState();
    _authState = context.read<AuthCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: Text('Настройки', style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: context.appColors.bgCard,
                leading: AvatarIcon(
                  size: 60,
                  imageUrl: _authState.user.imageUrl,
                  cacheManager: ImageStorage.instance.avatarManager,
                ),
                title: Text(
                  _authState.user.fullName ?? 'Duulat Bolsunbek uulu',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Фото профиля, имя, описание',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.appColors.disabled,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => context.pushNamed(AppRouteNames.settingsEditProfile),
              ),

              if (_authState.status == AuthStatus.authenticated) ...[
                const SizedBox(height: AppSpacing.lg),
                CardDrawerTitle(
                  icon: Icon(
                    Icons.confirmation_number_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: context.l10n.myTickets,
                  onTap: () => context.pushNamed(AppRouteNames.clientTourTickets),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(
                  Icons.brightness_6,
                  color: theme.colorScheme.primary,
                ),
                title: context.l10n.appTheme,
                onTap: () async => changeTheme(),
              ),

              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(Icons.language, color: theme.colorScheme.primary),
                title: context.l10n.appLanguage,
                onTap: changeLocale,
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                ),
                title: context.l10n.aboutUs,
                onTap: () => context.pushNamed(AppRouteNames.settingsAboutUs),
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(Icons.share, color: theme.colorScheme.primary),
                title: context.l10n.shareApp,
                onTap: () => AppLaunch.launchURL(''),
              ),
              if (_authState.status == AuthStatus.authenticated) ...[
                const SizedBox(height: AppSpacing.lg),
                CardDrawerTitle(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  title: context.l10n.logOut,
                  onTap: () => context.read<AuthCubit>().logout().then((value) {
                    if (context.mounted) {
                      context.goNamed(AppRouteNames.login);
                    }
                  }),
                ),
                const SizedBox(height: AppSpacing.lg),
                CardDrawerTitle(
                  icon: const Icon(Icons.delete_forever, color: Colors.red),
                  title: context.l10n.deleteAccount,
                  onTap: () => context.read<AuthCubit>().deleteAccount().then((value) {
                    if (context.mounted) {
                      context.goNamed(AppRouteNames.login);
                    }
                  }),
                ),
              ],

              const Spacer(),
              Text(
                '${context.l10n.version}1.0.0',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.appColors.disabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
