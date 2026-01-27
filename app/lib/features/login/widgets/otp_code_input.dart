import 'package:app/features/login/login.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class OtpCodeInput extends StatelessWidget {
  const OtpCodeInput({
    required this.email,
    required this.pinController,
    required this.focusNode,
    required this.smsRetriever,
    super.key,
  });

  final String email;
  final TextEditingController pinController;
  final FocusNode focusNode;
  final SmsRetriever smsRetriever;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        enableInteractiveSelection: true,
        controller: pinController,
        focusNode: focusNode,
        smsRetriever: smsRetriever,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        validator: (value) {
          if (value == null || value.length != 6) {
            return context.l10n.enter6Digits;
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
        onCompleted: (pin) {
          context.read<OtpCubit>().verifyOtpCode(
            email: email,
            pin: pin,
          );
        },
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: theme.colorScheme.error),
        ),
      ),
    );
  }
}
