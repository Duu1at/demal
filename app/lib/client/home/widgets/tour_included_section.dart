import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TourIncludedSection extends StatelessWidget {
  const TourIncludedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final included = [
      'Проживание в кемпинге',
      'Питание (завтрак, обед, ужин)',
      'Гид-проводник',
    ];
    final notIncluded = ['Авиабилеты', 'Личные расходы'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Что включено', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              ...included.map((item) => _buildRow(context, item, true)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Не включено', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              ...notIncluded.map((item) => _buildRow(context, item, false)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, String text, bool included) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            included ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 20,
            color: included ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
