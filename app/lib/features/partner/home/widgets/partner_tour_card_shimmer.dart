import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PartnerTourCardShimmer extends StatelessWidget {
  const PartnerTourCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.06),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: ShimmerContainer(
              height: 200,
              width: double.infinity,
              radius: 0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerContainer(
                            width: double.infinity,
                            height: 24,
                            radius: 4,
                          ),
                          SizedBox(height: AppSpacing.xs),
                          ShimmerContainer(
                            width: 100,
                            height: 20,
                            radius: 4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSpacing.xs),
                    ShimmerContainer(
                      width: 60,
                      height: 24,
                      radius: 4,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerContainer(
                      width: 150,
                      height: 16,
                      radius: 4,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    ShimmerContainer(
                      width: 200,
                      height: 16,
                      radius: 4,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm),
                ShimmerContainer(
                  width: 120,
                  height: 20,
                  radius: 4,
                ),
                SizedBox(height: AppSpacing.xs),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ShimmerContainer(
                        width: 100,
                        height: 40,
                        radius: 10,
                      ),
                      ShimmerContainer(
                        width: 150,
                        height: 40,
                        radius: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
