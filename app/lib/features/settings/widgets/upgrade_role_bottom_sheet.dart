import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';

class UpgradeRoleBottomSheet extends StatelessWidget {
  const UpgradeRoleBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return BottomSheets.showModalSettingsSheet(
      context: context,
      showDragHandle: true,
      isDismissible: false,
      enableDrag: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<VerifyStatusCubit>(),
          ),
          BlocProvider.value(
            value: context.read<AuthCubit>(),
          ),
        ],
        child: const UpgradeRoleBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<VerifyStatusCubit, RequestStatus<PartnerVerifyStatusModel>>(
      listener: (context, state) {
        if (state is RequestSuccess<PartnerVerifyStatusModel>) {
          final router = GoRouter.of(context);
          final authCubit = context.read<AuthCubit>();
          Navigator.of(context).pop();
          authCubit.updateProfile().then((_) {
            router.goNamed(AppRouteNames.partnerVerification);
          });
        }
        if (state is RequestFailure) {
          context.read<ErrorHandler>().handleError(state, context);
          Navigator.of(context).pop();
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
                context.l10n.roleUpgradeTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                context.l10n.roleUpgradeDescription,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xlg),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: CircularProgressIndicator.adaptive(),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        variant: AppButtonVariant.outline,
                        onPressed: () => Navigator.pop(context),
                        child: Text(context.l10n.cancel),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppButton(
                        onPressed: () {
                          context.goNamed(AppRouteNames.partnerVerification);
                        },
                        child: Text(context.l10n.confirm),
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
