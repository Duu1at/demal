import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  late final String phoneNumber;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    phoneNumber = '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: theme.textTheme.headlineSmall,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.onSurface, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: theme.colorScheme.primary, width: 1),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: theme.colorScheme.surface,
      ),
    );

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxlg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите код', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'На номер $phoneNumber было\n отправлено 4-значное сообщение OTP',
              style: theme.primaryTextTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.spaceUnit * 3),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                enableInteractiveSelection: true,
                controller: pinController,
                focusNode: focusNode,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                validator: (value) {
                  return value == '2222' ? null : 'Pin is incorrect';
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {},
                onChanged: (value) {},
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: theme.colorScheme.error),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg + 4),
            AppButton(child: const Text('Проверить'), onPressed: () {}),
            const SizedBox(height: AppSpacing.lg),
            TextButton(
              onPressed: () {},
              child: Text(
                'Отправить повторно (00:12)',
                style: theme.primaryTextTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
