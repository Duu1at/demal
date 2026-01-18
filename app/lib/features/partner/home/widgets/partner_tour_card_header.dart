import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PartnerTourCardHeader extends StatelessWidget {
  const PartnerTourCardHeader({
    required this.title,
    this.status,
    super.key,
  });

  final String? title;
  final String? status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title ?? context.l10n.noTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.3,
              letterSpacing: -0.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (status != null) ...[
          const SizedBox(width: AppSpacing.xs),
          PartnerTourStatusBadge(status: status!),
        ],
      ],
    );
  }
}

class PartnerTourStatusBadge extends StatelessWidget {
  const PartnerTourStatusBadge({
    required this.status,
    super.key,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusLower = status.toLowerCase();

    final (backgroundColor, textColor, localizedStatus) = switch (statusLower) {
      'active' || 'активный' => (
        theme.colorScheme.primaryContainer,
        theme.colorScheme.onPrimaryContainer,
        context.l10n.statusActive,
      ),
      'draft' || 'черновик' => (
        theme.colorScheme.surfaceContainerHighest,
        theme.colorScheme.onSurfaceVariant,
        context.l10n.statusDraft,
      ),
      'completed' || 'завершен' => (
        theme.colorScheme.tertiaryContainer,
        theme.colorScheme.onTertiaryContainer,
        context.l10n.statusCompleted,
      ),
      _ => (
        theme.colorScheme.surfaceContainerHighest,
        theme.colorScheme.onSurfaceVariant,
        status,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        localizedStatus,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
