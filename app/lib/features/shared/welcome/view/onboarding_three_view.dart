import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/features/shared/welcome/widgets/float_action_btn.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        onPressed: () {
          context.read<AuthCubit>().completeOnboarding();
          context.read<AuthCubit>().checkAuthStatus();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
