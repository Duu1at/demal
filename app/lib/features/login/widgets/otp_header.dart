import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final otpMessage = context.l10n.otpMessage(email);
    final parts = otpMessage.split(email);

    return Column(
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
                text: email,
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
      ],
    );
  }
}
