import 'package:app/app/mixin/settings_change_mixin.dart';
import 'package:app/app/router/app_router.dart';
import 'package:app/widgets/avatar_widget.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientSettingsView extends StatefulWidget {
  const ClientSettingsView({super.key});

  @override
  State<ClientSettingsView> createState() => _ClientSettingsViewState();
}

class _ClientSettingsViewState extends State<ClientSettingsView>
    with SettingsChangeMixin<ClientSettingsView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(title: Text('Профиль', style: theme.textTheme.titleLarge)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.lg),
              const AvatarWidget(
                avatarUrl:
                    'https://avatars.mds.yandex.net/i?id=b4f305847bbf6a7b444a16a92ef1556f_l-10132791-images-thumbs&n=13',
                size: 100,
                isActive: true,
                expand: true,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Bolsunbek uulu Duulat',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(
                  Icons.confirmation_number_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: 'Мои бронирование',
                onTap: () => context.goNamed(AppRouter.clientTourTickets),
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                ),
                title: 'О нас',
                onTap: () => context.goNamed(AppRouter.clientAboutUs),
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(
                  Icons.brightness_6,
                  color: theme.colorScheme.primary,
                ),
                title: 'Тема приложения',
                onTap: () async => await changeTheme(),
              ),

              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: Icon(Icons.language, color: theme.colorScheme.primary),
                title: 'Язык приложения',
                onTap: changeLocale,
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: const Icon(Icons.logout, color: Colors.red),
                title: 'Выйти',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.lg),
              CardDrawerTitle(
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                title: 'Удалить аккаунт',
                onTap: () {},
              ),
              const Spacer(),
              Text(
                'Версия 1.0.0',
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
