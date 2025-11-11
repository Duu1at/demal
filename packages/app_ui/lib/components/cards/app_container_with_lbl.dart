import 'package:flutter/material.dart';

class AppContainerWithLbl extends StatelessWidget {
  const AppContainerWithLbl({
    required this.label,
    required this.child,
    super.key,
  });
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).primaryTextTheme.bodyMedium),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
