import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CardDrawerTitle extends StatelessWidget {
  const CardDrawerTitle({
    required this.icon,
    required this.title,
    this.withBorder = false,
    this.tileColor,
    this.onTap,
    this.actionIcon,
    super.key,
  });

  final Widget icon;
  final Widget? actionIcon;
  final String title;
  final void Function()? onTap;
  final bool withBorder;
  final Color? tileColor;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final bg = context.appColors.bgCard;

    return Material(
      color: bg,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: withBorder
            ? BorderSide(
                color: color.onSurface.withValues(alpha: 0.2),
              )
            : BorderSide.none,
      ),
      shadowColor: context.appColors.grayShadow?.color,
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
                    color: color.secondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: icon),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              const Spacer(),
              actionIcon ??
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
