import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpgradeRoleBottomSheet extends StatelessWidget {
  const UpgradeRoleBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return BottomSheets.showModalSettingsSheet(
      context: context,
      showDragHandle: true,
      isDismissible: false,
      enableDrag: false,
      child: BlocProvider.value(
        value: context.read<UpgrateRoleCubit>(),
        child: const UpgradeRoleBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<UpgrateRoleCubit, RequestStatus<UserModel>>(
      listener: (context, state) {
        if (state is RequestSuccess<UserModel>) {}
        if (state is RequestFailure) {
          Navigator.of(context).pop();
          context.read<ErrorHandler>().handleError(state, context);
        }
      },
      builder: (context, state) {
        final isLoading = state is RequestLoading;

        return Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: .1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.business_center_outlined,
                  color: theme.colorScheme.primary,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Стать организатором',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'После смены роли на организатора вам будут недоступны функции клиента. Вы сможете создавать и управлять турами, но не сможете бронировать туры как клиент.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xlg),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: CircularProgressIndicator(),
                )
              else
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
                        onPressed: () {
                          context.read<UpgrateRoleCubit>().upgradeToPartner();
                        },
                        child: const Text('Подтвердить'),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        );
      },
    );
  }
}
