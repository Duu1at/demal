import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TourProgramSection extends StatelessWidget {
  const TourProgramSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int count = 1;
    final program = [
      {
        'day': 'День 1',
        'desc':
            'Встреча группы в Бишкеке, выезд в Ала-Арчу, установка лагеря и прогулка по ущелью.',
      },
      {
        'day': 'День 2',
        'desc': 'Поход к водопаду и пикник. Возвращение к лагерю вечером.',
      },
      {'day': 'День 3', 'desc': 'Завтрак, сбор лагеря и возвращение в Бишкек.'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Программа тура", style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        ...program.map(
          (e) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
              child: Text('${count++}'),
            ),
            title: Text(
              e['day']!,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(e['desc']!, style: theme.textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }
}
