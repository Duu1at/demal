import 'package:app_ui/src/colors/app_shadows_extension.dart';
import 'package:flutter/material.dart';

class CardWithBorder extends StatelessWidget {
  const CardWithBorder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final customShadows = Theme.of(context).extension<AppShadowsExtension>()!;
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: customShadows.cardShadow,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
