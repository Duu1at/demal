import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PartnerToursErrorState extends StatelessWidget {
  const PartnerToursErrorState({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;

    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isLight
                        ? [
                            AppColors.red.shade10 ?? AppColors.red,
                            AppColors.red.withValues(alpha: 0.3),
                          ]
                        : [
                            AppColors.red.withValues(alpha: 0.15),
                            AppColors.red.withValues(alpha: 0.25),
                          ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.error.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 56,
                  color: colorScheme.error.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: AppSpacing.xlg),
              Text(
                context.l10n.failedToLoadToursTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                context.l10n.checkInternetAndTryAgain,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.xxlg),
                AppButton(
                  onPressed: onRetry,
                  leading: const Icon(Icons.refresh_rounded, size: 20),
                  child: Text(context.l10n.tryAgain),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
