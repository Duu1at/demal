import 'dart:async';

import 'package:app/l10n/l10n_extension.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpForm extends StatefulWidget {
  const OtpForm(this.phoneNumer, {super.key});
  final String phoneNumer;
  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  static const int _initialSeconds = 120;
  late int _remainingSeconds;
  Timer? _timer;

  bool get _isTimerFinished => _remainingSeconds == 0;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    _remainingSeconds = _initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingSeconds = _initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final phone = '+996 ${widget.phoneNumer}';
    final otpMessage = context.l10n.otpMessage(phone);
    final parts = otpMessage.split(phone);
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
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: parts[0],
                    style: theme.primaryTextTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: phone,
                    style: theme.primaryTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (parts.length > 1)
                    TextSpan(
                      text: parts[1],
                      style: theme.primaryTextTheme.bodyMedium,
                    ),
                ],
              ),
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
            AppButton(
              child: const Text('Проверить'),
              onPressed: () => _success(context),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextButton(
              onPressed: _isTimerFinished
                  ? () {
                      _startTimer();
                    }
                  : null,
              child: Text(
                'Отправить повторно ${_isTimerFinished ? '' : '(${_formatTime(_remainingSeconds)})'}',
                style: theme.primaryTextTheme.titleSmall!.copyWith(
                  color: _isTimerFinished
                      ? theme.colorScheme.primary
                      : theme.disabledColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _success(BuildContext context) {
    AlertDialogs.alertDialog(
      barrierDismissible: false,
      title: 'Успешно',
      subTitle: 'Вы успешно авторизовались',
      context: context,
      showCloseButton: false,
      typeAlertDialog: AlertDialogType.success,
      actions: [
        AppButton(
          size: AppButtonSize.sm,
          onPressed: () => Navigator.pop(context),
          child: const Text('Продолжить'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
