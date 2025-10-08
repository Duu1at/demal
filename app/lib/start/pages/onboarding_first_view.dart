import 'package:app/l10n/l10n_extension.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class OnboardingFirstView extends StatelessWidget {
  const OnboardingFirstView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldOnboarding(
      image: Assets.images.onboarding1.provider(),
      appBar: AppBar(elevation: 0),
      body: Column(
        children: [
          Assets.images.illustration2.image(),
          Text(context.l10n.appTitle),
          const Text('Сотни предложений на выходные в одной удобной ленте'),
        ],
      ),
      floatingActionButton: AppButton(
        onPressed: () {},
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: const Text('Следующий'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
