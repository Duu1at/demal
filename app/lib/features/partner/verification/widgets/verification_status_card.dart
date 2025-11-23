import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class VerificationStatusCard extends StatelessWidget {
  const VerificationStatusCard({
    required this.status,
    super.key,

    this.adminComments,
  });

  final VerificationStatusType status;
  final String? adminComments;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          if (adminComments != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _buildComments(context),
          ],
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final text = switch (status) {
      VerificationStatusType.pending => 'Заявка на проверке',
      VerificationStatusType.rejected => 'Заявка отклонена',
      VerificationStatusType.verified => 'Заявка верифицирована',
    };

    final color = switch (status) {
      VerificationStatusType.pending => Theme.of(context).colorScheme.primaryContainer,
      VerificationStatusType.rejected => Theme.of(context).colorScheme.errorContainer,
      VerificationStatusType.verified => Theme.of(context).colorScheme.tertiaryContainer,
    };

    final textColor = switch (status) {
      VerificationStatusType.pending => Theme.of(context).colorScheme.onPrimaryContainer,
      VerificationStatusType.rejected => Theme.of(context).colorScheme.onErrorContainer,
      VerificationStatusType.verified => Theme.of(context).colorScheme.onTertiaryContainer,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor),
      ),
    );
  }

  Widget _buildComments(BuildContext context) {
    final textColor = switch (status) {
      VerificationStatusType.pending => Theme.of(context).colorScheme.onPrimaryContainer,
      VerificationStatusType.rejected => Theme.of(context).colorScheme.onErrorContainer,
      VerificationStatusType.verified => Theme.of(context).colorScheme.onTertiaryContainer,
    };

    return Text(
      adminComments!,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
    );
  }
}

enum VerificationStatusType {
  pending,
  rejected,
  verified,
}
