import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.onLeadingPressed,
    this.onTrailingPressed,
  });

  final void Function()? onLeadingPressed;
  final void Function()? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      leading: IconButton(
        onPressed: onLeadingPressed,
        icon: Assets.icons.bullet.svg(width: 24, height: 24),
      ),
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          'Demal',
          style: theme.primaryTextTheme.titleLarge?.copyWith(),
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          'Бишкек',
          style: theme.primaryTextTheme.labelSmall?.copyWith(),
          textAlign: TextAlign.center,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: onTrailingPressed,
          icon: Assets.icons.bell.svg(width: 24, height: 24),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
