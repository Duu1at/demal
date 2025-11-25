import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PartnerToursLoadingState extends StatelessWidget {
  const PartnerToursLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          8,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.lg),
            child: _ShimmerTile(),
          ),
        ),
      ),
    );
  }
}

class _ShimmerTile extends StatelessWidget {
  const _ShimmerTile();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.md),
      child: const ShimmerContainer(
        height: 120,
        width: double.infinity,
      ),
    );
  }
}
