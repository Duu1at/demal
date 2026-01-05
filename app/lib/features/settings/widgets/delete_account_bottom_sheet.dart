import 'package:app/app/app.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return BottomSheets.showModalSettingsSheet(
      context: context,
      showDragHandle: true,
      child: BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: const DeleteAccountBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: .1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete_forever,
              color: Colors.red,
              size: 48,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Удалить аккаунт',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Вы уверены, что хотите удалить свой аккаунт? Это действие необратимо, и все ваши данные будут удалены навсегда.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xlg),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  variant: AppButtonVariant.outline,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  variant: AppButtonVariant.destructive,
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<AuthCubit>().deleteAccount().then((value) {
                      if (context.mounted) {
                        context.goNamed(AppRouteNames.login);
                      }
                    });
                  },
                  child: const Text('Удалить'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
