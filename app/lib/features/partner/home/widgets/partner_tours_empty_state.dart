import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PartnerToursEmptyState extends StatelessWidget {
  const PartnerToursEmptyState({super.key});

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
                            AppColors.orange.shade0 ?? AppColors.orange,
                            AppColors.orange.shade10 ?? AppColors.orange,
                          ]
                        : [
                            AppColors.orange.withValues(alpha: 0.15),
                            AppColors.orange.withValues(alpha: 0.25),
                          ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.explore,
                  size: 56,
                  color: colorScheme.primary.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: AppSpacing.xlg),
              Text(
                context.l10n.noToursYet,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                context.l10n.createFirstTourAction,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
