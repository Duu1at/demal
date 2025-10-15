import 'package:app/l10n/l10n_extension.dart';
import 'package:app/welcome/welcome.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingTwoView extends StatelessWidget {
  const OnboardingTwoView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldOnboarding(
      image: Assets.images.onboarding2.provider(),
      appBar: AppBar(elevation: 0, automaticallyImplyLeading: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Assets.images.illustration2.image(),
          ),
        ],
      ),
      floatingActionButton: FloatActionBtn(
        title: context.l10n.onboardingTitle2,
        subtitle: context.l10n.onboardingSubTitle2,
        fillPointIndex: 1,
        textBtn: context.l10n.next,
        onPressed: () => context.goNamed(AppRouter.onboardingThree),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
