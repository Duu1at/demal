import 'package:app/l10n/l10n_extension.dart';
import 'package:app/start/widgets/float_action_btn.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class Onboarding3View extends StatelessWidget {
  const Onboarding3View({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldOnboarding(
      image: Assets.images.onboarding3.provider(),
      appBar: AppBar(elevation: 0),
      floatingActionButton: FloatActionBtn(
        title: context.l10n.onboardingTitle3,
        subtitle: context.l10n.onboardingSubTitle3,
        fillPointIndex: 2,
        textBtn: context.l10n.next,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
