import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class BgImageOnboarding extends StatelessWidget {
  const BgImageOnboarding({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const BgImageOnboarding());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldOnboarding(
      appBar: AppBar(elevation: 0, title: const Text('Background Image Body')),
      image: Assets.images.onboarding3.provider(),
    );
  }
}
