import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class OnboardingFirstView extends StatelessWidget {
  const OnboardingFirstView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldOnboarding(
      appBar: AppBar(elevation: 0, title: const Text('Onboarding First View')),
      image: Assets.images.onboarding1.provider(),
      body: Column(children: [Text('tet')]),
    );
  }
}
