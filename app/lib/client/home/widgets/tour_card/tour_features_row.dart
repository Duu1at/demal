import 'package:flutter/material.dart';

class TourFeaturesRow extends StatelessWidget {
  const TourFeaturesRow({required this.features, super.key});

  final List<String> features;

  @override
  Widget build(BuildContext context) {
    if (features.isEmpty) return const SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 6,
      runSpacing: 2,
      children: features
          .map(
            (feature) => Text(
              feature,
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
            ),
          )
          .toList(),
    );
  }
}
