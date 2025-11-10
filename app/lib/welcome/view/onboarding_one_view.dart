import 'package:app/app/router/app_router.dart';
import 'package:app/l10n/l10n_extension.dart';
import 'package:app/welcome/welcome.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingOneView extends StatelessWidget {
  const OnboardingOneView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldOnboarding(
      image: Assets.images.onboarding1.provider(),
      appBar: AppBar(elevation: 0, automaticallyImplyLeading: false),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Assets.images.illustration1.image(),
          ),
        ],
      ),
      floatingActionButton: FloatActionBtn(
        title: context.l10n.onboardingTitle1,
        subtitle: context.l10n.onboardingSubTitle1,
        fillPointIndex: 0,
        textBtn: context.l10n.next,
        onPressed: () => context.goNamed(AppRouter.onboardingTwo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
