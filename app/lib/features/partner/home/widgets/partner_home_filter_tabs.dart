import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

enum TourFilter { active, inactive }

class PartnerHomeFilterTabs extends StatelessWidget {
  const PartnerHomeFilterTabs({
    required this.selectedFilter,
    required this.onFilterChanged,
    super.key,
  });

  final TourFilter selectedFilter;
  final ValueChanged<TourFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: _FilterTab(
                label: 'Активные',
                isSelected: selectedFilter == TourFilter.active,
                onTap: () => onFilterChanged(TourFilter.active),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _FilterTab(
                label: 'Неактивные',
                isSelected: selectedFilter == TourFilter.inactive,
                onTap: () => onFilterChanged(TourFilter.inactive),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
