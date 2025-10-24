import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'map_widget.dart';

class TourLocationSection extends StatelessWidget {
  const TourLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Место сбора", style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Text(
          "Площадь Ала-Тоо, Бишкек",
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          child: const SizedBox(
            height: 200,
            child: MapWidget(),
          ),
        ),
      ],
    );
  }
}
