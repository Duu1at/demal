import 'package:flutter/material.dart';

class ToursLoadingState extends StatelessWidget {
  const ToursLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
