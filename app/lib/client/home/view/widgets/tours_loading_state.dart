import 'package:flutter/material.dart';

/// Виджет для отображения состояния загрузки
class ToursLoadingState extends StatelessWidget {
  const ToursLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

