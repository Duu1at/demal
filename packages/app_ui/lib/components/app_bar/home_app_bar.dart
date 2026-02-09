import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.onMenuTap,
  });

  final VoidCallback? onMenuTap;

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
      title: Text('Demal', style: theme.primaryTextTheme.titleLarge),
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: const [],
    );
  }
}
