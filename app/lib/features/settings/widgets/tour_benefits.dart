import 'package:app/features/settings/widgets/bullet_point.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TourBenefits extends StatelessWidget {
  const TourBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final baseTextStyle = textTheme.labelLarge ?? const TextStyle();
    final boldStyle = textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700) ?? const TextStyle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(context.l10n.appDescription, style: baseTextStyle),
        const SizedBox(height: AppSpacing.md),
        Text(context.l10n.withUsYouGet, style: boldStyle),
        const SizedBox(height: AppSpacing.sm),
        BulletPoint(
          textSpans: [
            TextSpan(text: context.l10n.timeSavingTitle, style: boldStyle),
            TextSpan(
              style: baseTextStyle,
              text: context.l10n.timeSavingDescription,
            ),
          ],
        ),
        BulletPoint(
          textSpans: [
            TextSpan(text: context.l10n.safetyAndTrustTitle, style: boldStyle),
            TextSpan(
              text: context.l10n.safetyAndTrustDescription,
              style: baseTextStyle,
            ),
          ],
        ),
        BulletPoint(
          textSpans: [
            TextSpan(
              text: context.l10n.simplicityAndConvenienceTitle,
              style: boldStyle,
            ),
            TextSpan(
              text: context.l10n.simplicityAndConvenienceDescription,
              style: baseTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
