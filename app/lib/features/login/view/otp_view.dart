import 'package:app/features/login/login.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class OtpView extends StatelessWidget {
  const OtpView(this.email, {super.key});
  final String email;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      appBar: AppBar(elevation: 0, title: Text(context.l10n.verify)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xxxlg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Assets.images.otpImage.image()],
            ),
            const SizedBox(height: AppSpacing.spaceUnit * 3.5),
            OtpForm(email),
          ],
        ),
      ),
    );
  }
}
