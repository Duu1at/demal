import 'package:app/features/login/cubit/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpResendButton extends StatelessWidget {
  const OtpResendButton({required this.email, super.key});
  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<OtpCubit, OtpState>(
      buildWhen: (p, c) => p.remainingSeconds != c.remainingSeconds,
      builder: (context, state) {
        final isTimerFinished = state.remainingSeconds <= 0;
        return TextButton(
          onPressed: isTimerFinished ? () => context.read<OtpCubit>().sendOtp(email) : null,
          child: Text(
            'Отправить повторно ${isTimerFinished ? '' : '(${state.remainingSeconds.formatTime()})'}',
            style: theme.primaryTextTheme.titleSmall!.copyWith(
              color: isTimerFinished ? theme.colorScheme.primary : theme.disabledColor,
            ),
          ),
        );
      },
    );
  }
}

extension IntX on num {
  String formatTime() {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final secs = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
