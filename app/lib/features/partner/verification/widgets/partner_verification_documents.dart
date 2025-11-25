import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PartnerVerificationDocuments extends StatelessWidget {
  const PartnerVerificationDocuments({
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
          Text(
            'Прикрепите документы или фотографии документов',
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Пожалуйста, приложите реальное фото документа',
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (state.documentUrls.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: state.documentUrls.map((url) {
                return Chip(
                  label: const Text('Документ'),
                  onDeleted: () {},
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: AppSpacing.xlg),
          _PartnerVerificationActionButton(
            label: 'Выбрать файлы',
            isLoading: state.isUploadingDocuments,
            onPressed: () => cubit.pickDocuments(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          _PartnerVerificationActionButton(
            label: 'Сделать фото',
            variant: AppButtonVariant.outline,
            isLoading: state.isUploadingDocuments,
            onPressed: () => cubit.takePhoto(context),
          ),
        ],
      ),
    );
  }
}

class _PartnerVerificationActionButton extends StatelessWidget {
  const _PartnerVerificationActionButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final AppButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      variant: variant,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }
}
