import 'package:app_ui/app_ui.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shadowColor: color.primary.withValues(alpha: 0.1),
        color: tileColor,
        elevation: 13,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: withBorder
              ? BorderSide(
                  color: color.onSurface.withValues(alpha: 0.1),
                  width: 1,
                )
              : BorderSide.none,
        ),
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

  // @override
  // Widget build(BuildContext context) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   return ListTile(
  //     tileColor: tileColor,
  //     onTap: onTap,
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(16),
  //       side: withBorder
  //           ? BorderSide(color: colorScheme.secondary, width: 0)
  //           : BorderSide.none,
  //     ),
  //     leading: SizedBox(
  //       width: 40,
  //       height: 40,
  //       child: DecoratedBox(
  //         decoration: const BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: Colors.amber,
  //         ),
  //         child: SizedBox(width: 24, height: 24, child: icon),
  //       ),
  //     ),
  //     title: Text(title),
  //     trailing: const Icon(Icons.arrow_forward_ios),
  //   );
  // }
}
