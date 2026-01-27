import 'package:app/features/login/login.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:smart_auth/smart_auth.dart';

class OtpForm extends StatefulWidget {
  const OtpForm(this.email, {super.key});
  final String email;
  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late final SmsRetrieverImpl smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    smsRetriever = SmsRetrieverImpl(SmartAuth.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxlg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OtpHeader(email: widget.email),
            const SizedBox(height: AppSpacing.spaceUnit * 3),
            OtpCodeInput(
              email: widget.email,
              pinController: pinController,
              focusNode: focusNode,
              smsRetriever: smsRetriever,
            ),
            const SizedBox(height: AppSpacing.lg + 4),
            OtpVerifyButton(
              email: widget.email,
              formKey: formKey,
              pinController: pinController,
              focusNode: focusNode,
            ),
            const SizedBox(height: AppSpacing.lg),
            OtpResendButton(email: widget.email),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    smsRetriever.dispose();
    super.dispose();
  }
}
