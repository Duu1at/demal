import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PartnerVerificationDocument extends StatelessWidget {
  const PartnerVerificationDocument({
    required this.state,
    required this.cubit,
    super.key,
  });

  final PartnerVerificationState state;
  final PartnerVerificationCubit cubit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (state.documentUrl != null && state.documentUrl!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: Row(
                children: [
                  const Icon(Icons.description_outlined),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      context.l10n.documentUploaded,
                      style: textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: cubit.removeDocument,
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              context.l10n.ipCertificateScan,
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.uploadIpCertificateHint,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xlg),
            if (state.isUploadingDocument)
              const Center(child: CircularProgressIndicator.adaptive())
            else
              _PartnerVerificationActionButton(
                label: context.l10n.chooseFilesButton,
                onPressed: () => cubit.pickAndUploadDocument(context),
              ),
          ],
        ],
      ),
    );
  }
}

class _PartnerVerificationActionButton extends StatelessWidget {
  const _PartnerVerificationActionButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      variant: AppButtonVariant.outline,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
