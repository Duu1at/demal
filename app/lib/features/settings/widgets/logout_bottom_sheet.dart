import 'package:app/app/app.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return BottomSheets.showModalSettingsSheet(
      context: context,
      showDragHandle: true,
      child: BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: const LogoutBottomSheet(),
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
              Icons.logout,
              color: Colors.red,
              size: 48,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.l10n.logoutTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.l10n.logoutConfirmation,
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
                  child: Text(context.l10n.cancel),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  variant: AppButtonVariant.destructive,
                  onPressed: () {
                    final authCubit = context.read<AuthCubit>();
                    final router = GoRouter.of(context);
                    Navigator.pop(context);
                    authCubit.logout().then((_) {
                      router.goNamed(AppRouteNames.login);
                    });
                  },
                  child: Text(context.l10n.logOut),
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
