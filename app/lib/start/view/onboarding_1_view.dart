import 'package:app/l10n/l10n_extension.dart';
import 'package:app/start/start.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class Onboarding1View extends StatelessWidget {
  const Onboarding1View({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldOnboarding(
      image: Assets.images.onboarding1.provider(),
      appBar: AppBar(elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
