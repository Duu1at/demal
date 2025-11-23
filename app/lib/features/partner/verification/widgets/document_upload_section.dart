import 'dart:io';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class DocumentUploadSection extends StatelessWidget {
  const DocumentUploadSection({
    required this.documentFile,
    required this.documentUrl,
    required this.onPickDocument,
    super.key,
  });

  final File? documentFile;
  final String? documentUrl;
  final VoidCallback onPickDocument;

  @override
  Widget build(BuildContext context) {
    final hasDocument = documentFile != null || documentUrl != null;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitle(context),
          const SizedBox(height: AppSpacing.sm),
          _buildDescription(context),
          const SizedBox(height: AppSpacing.lg),
          if (hasDocument) _buildDocumentInfo(context) else _buildUploadButtons(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Прикрепите фото документа',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'Пожалуйста, приложите реальное фото документа',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _buildDocumentInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.description,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              documentFile?.path.split('/').last ?? 'Документ загружен',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButtons(BuildContext context) {
    return Column(
      children: [
        AppButton(
          variant: AppButtonVariant.primary,
          onPressed: onPickDocument,
          child: const Text('Сделать снимок'),
        ),
        const SizedBox(height: AppSpacing.sm),
        ReusableTextButton(
          label: 'Открыть галерею',
          onPressed: onPickDocument,
        ),
      ],
    );
  }
}
