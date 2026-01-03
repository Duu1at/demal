import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app/utils/utils.dart';
import 'package:core/core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpgrateRoleCubit(context.read<ProfileRepository>()),
        ),
      ],
      child: const SettingsViewBody(),
    );
  }
}

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> with SettingsChangeMixin<SettingsViewBody> {
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

              if (_authState.status == AuthStatus.authenticated && _authState.user.isClient) ...[
                const SizedBox(height: AppSpacing.lg),
                CardDrawerTitle(
                  icon: Icon(
                    Icons.business_center_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: 'Стать организатором',
                  onTap: () => UpgradeRoleBottomSheet.show(context),
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
                  onTap: () => LogoutBottomSheet.show(context),
                ),
                const SizedBox(height: AppSpacing.lg),
                CardDrawerTitle(
                  icon: const Icon(Icons.delete_forever, color: Colors.red),
                  title: context.l10n.deleteAccount,
                  onTap: () => DeleteAccountBottomSheet.show(context),
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
