import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.onMenuTap,
    this.onNotificationTap,
  });

  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      leading: IconButton(
        onPressed: onMenuTap,
        icon: Assets.icons.bullet.svg(
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            theme.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Column(
        children: [
          Text('Demal', style: theme.primaryTextTheme.titleLarge),
          Text('Бишкек', style: theme.primaryTextTheme.labelSmall),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        IconButton(
          onPressed: onNotificationTap,
          icon: Assets.icons.bell.svg(
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              theme.colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
