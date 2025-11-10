import 'package:app/app/cubits/auth/auth_cubit.dart';
import 'package:app/app/mixin/settings_change_mixin.dart';
import 'package:app/app/router/app_router.dart';
import 'package:app/l10n/l10n_extension.dart';
import 'package:app/widgets/avatar_widget.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/launch/app_launch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ClientSettingsView extends StatefulWidget {
  const ClientSettingsView({super.key});

  @override
  State<ClientSettingsView> createState() => _ClientSettingsViewState();
}

class _ClientSettingsViewState extends State<ClientSettingsView> with SettingsChangeMixin<ClientSettingsView> {
  String? pathUrl;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: Text(context.l10n.profile, style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              AvatarWidget(
                avatarUrl: pathUrl,
                size: 80,
                isActive: true,
                expand: true,
                onUpdate: (bytesImge) {},
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Bolsunbek uulu Duulat'.toUpperCase(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(
                  Icons.confirmation_number_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: context.l10n.myTickets,
                onTap: () => context.pushNamed(AppRouter.clientTourTickets),
              ),
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
                onTap: () => context.pushNamed(AppRouter.clientAboutUs),
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(Icons.share, color: theme.colorScheme.primary),
                title: context.l10n.shareApp,
                onTap: () => AppLaunch.launchURL(''),
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: const Icon(Icons.logout, color: Colors.red),
                title: context.l10n.logOut,
                onTap: () => context.read<AuthCubit>().logout(),
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                title: context.l10n.deleteAccount,
                onTap: () => context.read<AuthCubit>().deleteAccount(),
              ),
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
