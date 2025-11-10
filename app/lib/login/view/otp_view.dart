import 'package:app/login/cubit/otp_cubit.dart';
import 'package:app/login/login.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpView extends StatelessWidget {
  const OtpView(this.phoneNumer, {super.key});
  final String phoneNumer;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      appBar: AppBar(elevation: 0, title: const Text('Verify')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xxxlg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Assets.images.otpImage.image()],
            ),
            const SizedBox(height: AppSpacing.spaceUnit * 3.5),
            BlocProvider(
              create: (context) => OtpCubit(context.read<AuthRepository>())..sendOtp(phoneNumer),
              child: OtpForm(phoneNumer),
            ),
          ],
        ),
      ),
    );
  }
}
