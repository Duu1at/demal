import 'package:app/app/router/app_router.dart';
import 'package:app/l10n/l10n_extension.dart';
import 'package:app/welcome/widgets/float_action_btn.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingThreeView extends StatelessWidget {
  const OnboardingThreeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldOnboarding(
      image: Assets.images.onboarding3.provider(),
      appBar: AppBar(elevation: 0, automaticallyImplyLeading: false),
      floatingActionButton: FloatActionBtn(
        title: context.l10n.onboardingTitle3,
        subtitle: context.l10n.onboardingSubTitle3,
        fillPointIndex: 2,
        textBtn: context.l10n.next,
        onPressed: () => context.goNamed(AppRouter.login),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
