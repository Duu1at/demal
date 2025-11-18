import 'package:app/app/app.dart';
import 'package:app/login/cubit/otp_cubit.dart';
import 'package:app/utils/formatter/input_formatter.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class OtpForm extends StatefulWidget {
  const OtpForm(this.phoneNumer, {super.key});
  final String phoneNumer;
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
        border: Border.all(color: theme.colorScheme.onSurface),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: theme.colorScheme.primary),
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
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                enableInteractiveSelection: true,
                controller: pinController,
                focusNode: focusNode,
                smsRetriever: smsRetriever,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                validator: (value) {
                  if (value == null || value.length != 4) {
                    return 'Введите 4 цифры';
                  }
                  return null;
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) async {
                  await context.read<OtpCubit>().verifyOtpCode(
                    phoneNumber: widget.phoneNumer,
                    pin: pin,
                  );
                },
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: theme.colorScheme.error),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg + 4),
            BlocListener<OtpCubit, OtpState>(
              listenWhen: (p, c) => p.verifyStatus != c.verifyStatus,
              listener: (context, state) {
                final verifyStatus = state.verifyStatus;
                if (verifyStatus is RequestSuccess<AuthLoginModel>) {
                  context.read<AuthCubit>().checkAuthStatus();
                }
                if (verifyStatus is RequestFailure<AuthLoginModel>) {
                  context.read<ErrorHandler>().handleError(
                    verifyStatus.exception,
                    context,
                  );
                  pinController.clear();
                  focusNode.requestFocus();
                }
              },
              child: AppButton(
                child: const Text('Проверить'),
                onPressed: () async {
                  focusNode.unfocus();
                  if (formKey.currentState!.validate()) {
                    final pin = pinController.text.trim();
                    await context.read<OtpCubit>().verifyOtpCode(
                      phoneNumber: widget.phoneNumer,
                      pin: pin,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            BlocBuilder<OtpCubit, OtpState>(
              buildWhen: (p, c) => p.remainingSeconds != c.remainingSeconds,
              builder: (context, state) {
                final isTimerFinished = state.remainingSeconds <= 0;
                return TextButton(
                  onPressed: isTimerFinished ? () => context.read<OtpCubit>().sendOtp(widget.phoneNumer) : null,
                  child: Text(
                    'Отправить повторно ${isTimerFinished ? '' : '(${state.remainingSeconds.formatTime()})'}',
                    style: theme.primaryTextTheme.titleSmall!.copyWith(
                      color: isTimerFinished ? theme.colorScheme.primary : theme.disabledColor,
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

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    smsRetriever.dispose();
    super.dispose();
  }
}

extension IntX on num {
  String formatTime() {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final secs = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
