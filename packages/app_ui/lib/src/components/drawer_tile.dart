import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/colors/app_shadows_extension.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    required this.icon,
    required this.title,
    this.withBorder = false,
    this.tileColor,
    this.onTap,
    this.subtitle,
    super.key,
  });

  final Widget icon;
  final String title;
  final void Function()? onTap;
  final bool withBorder;
  final Color? tileColor;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final customShadows = Theme.of(context).extension<AppShadowsExtension>()!;
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: withBorder
            ? BorderSide(
                color: color.onSurface.withValues(alpha: 0.2),
                width: 1,
              )
            : BorderSide.none,
      ),
      shadowColor: customShadows.cardShadow.isEmpty 
          ? Colors.transparent 
          : customShadows.cardShadow.first.color, 
      child: InkWell(
        splashColor: color.onSurface.withValues(alpha: 0.2),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondary.withValues(alpha: 0.5),
                child: icon,
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text(
                    subtitle ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),

              const Spacer(),
              Assets.icons.arrowRight.svg(
                width: 24,
                colorFilter: ColorFilter.mode(color.onSurface, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
