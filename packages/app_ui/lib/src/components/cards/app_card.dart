import 'package:app_ui/src/colors/app_theme_color_extension.dart';
import 'package:app_ui/src/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: context.appColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          context.appColors.grayShadow ??
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.2),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: child),
    );
  }
}
