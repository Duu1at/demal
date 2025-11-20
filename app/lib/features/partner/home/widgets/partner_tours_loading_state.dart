import 'package:flutter/material.dart';

class PartnerToursLoadingState extends StatelessWidget {
  const PartnerToursLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
