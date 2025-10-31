import 'package:app/l10n/l10n_extension.dart';
import 'package:app/login/cubit/otp_cubit.dart';
import 'package:app/utils/formatter/input_formatter.dart';
import 'package:app/utils/styled_toasts.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:core/network/extension/object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final phone = '+996 ${InputFormatters.formatPhone(widget.phoneNumer)}';
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
                  if (value == null || value.length != 4) {
                    return 'Введите 4 цифры';
                  }
                  return null;
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  context.read<OtpCubit>().verifyOtpCode(
                    phoneNumber: widget.phoneNumer,
                    pin: pin,
                  );
                },
                onChanged: (value) {},
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: theme.colorScheme.error),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg + 4),
            BlocListener<OtpCubit, OtpState>(
              listener: (context, state) {
                final verifyStatus = state.verifyStatus;
                if (verifyStatus.isSuccess) {
                } else if (verifyStatus is RequestFailure) {
                  AppSnackBar.showBaseSnack(verifyStatus.parseError());
                }
              },
              child: AppButton(
                child: const Text('Проверить'),
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final pin = pinController.text.trim();
                    context.read<OtpCubit>().verifyOtpCode(
                      phoneNumber: widget.phoneNumer,
                      pin: pin,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            BlocConsumer<OtpCubit, OtpState>(
              listener: (context, state) {
                final sendStatus = state.sendStatus;
                if (sendStatus is RequestFailure) {
                  AppSnackBar.showBaseSnack(sendStatus.exception.parseError());
                }
              },
              builder: (context, state) {
                final isTimerFinished = state.remainingSeconds <= 0;
                return TextButton(
                  onPressed: isTimerFinished
                      ? () =>
                            context.read<OtpCubit>().sendOtp(widget.phoneNumer)
                      : null,
                  child: Text(
                    'Отправить повторно ${isTimerFinished ? '' : '(${_formatTime(state.remainingSeconds)})'}',
                    style: theme.primaryTextTheme.titleSmall!.copyWith(
                      color: isTimerFinished
                          ? theme.colorScheme.primary
                          : theme.disabledColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
