import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ToursEmptyState extends StatelessWidget {
  const ToursEmptyState({
    required this.hasSearchQuery,
    super.key,
  });

  final bool hasSearchQuery;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No tours found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (hasSearchQuery) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Try adjusting your search',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

