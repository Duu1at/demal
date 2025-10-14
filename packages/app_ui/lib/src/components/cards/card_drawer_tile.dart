import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/colors/app_theme_color_extension.dart';
import 'package:flutter/material.dart';

class CardDrawerTile extends StatelessWidget {
  const CardDrawerTile({
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
      shadowColor: context.appcolors.grayShadow?.color,
      child: InkWell(
        splashColor: color.onSurface.withValues(alpha: 0.2),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: icon),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
