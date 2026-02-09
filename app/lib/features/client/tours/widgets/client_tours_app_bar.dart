import 'package:app/app/app.dart';
import 'package:app/widgets/widgets.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientToursAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClientToursAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppBar(
      title: 'Demal',
      leading: IconButton(
        onPressed: () => context.pushNamed(AppRouteNames.settings),
        icon: Assets.icons.bullet.svg(
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
      actions: const [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
