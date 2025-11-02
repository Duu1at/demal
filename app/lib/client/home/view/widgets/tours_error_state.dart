import 'package:app/client/home/blocs/tours/tours_bloc.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Виджет для отображения ошибки загрузки туров
class ToursErrorState extends StatelessWidget {
  const ToursErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to load tours',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(
              onPressed: () {
                context.read<ToursBloc>().add(const ToursRefreshEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

