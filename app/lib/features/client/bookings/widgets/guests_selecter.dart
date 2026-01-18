import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GuestsSelector extends StatelessWidget {
  const GuestsSelector({
    required this.count,
    required this.onChanged,
    this.maxGuests,
    super.key,
  });
  final int count;
  final int? maxGuests;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(context.l10n.guests, style: theme.textTheme.titleMedium),
        Row(
          children: [
            _CountButton(
              icon: Icons.remove,
              onPressed: count > 1 ? () => onChanged(count - 1) : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text('$count', style: theme.textTheme.titleMedium),
            ),
            _CountButton(
              icon: Icons.add,
              onPressed: (maxGuests == null || count < maxGuests!) ? () => onChanged(count + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}

class _CountButton extends StatelessWidget {
  const _CountButton({required this.icon, this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Ink(
      width: 40,
      height: 38,
      decoration: BoxDecoration(
        color: onPressed != null
            ? colorScheme.primary.withValues(alpha: 0.15)
            : context.appColors.disabled!.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        splashRadius: 20,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
