import 'package:app/settings/widgets/tour_benefits.dart';
import 'package:app/utils/utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(
        elevation: 0,
        title: Text(context.l10n.aboutUs, style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Demal',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '${context.l10n.lastUpdate} Декабрь 10, 2023',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.appColors.disabled,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const TourBenefits(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: DividerHorisontal()),
                  const SizedBox(width: AppSpacing.sm),
                  Text(context.l10n.contactUs),
                  const SizedBox(width: AppSpacing.sm),
                  const Expanded(child: DividerHorisontal()),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCard(
                    child: GestureDetector(
                      onTap: () => AppLaunch.makeCall('0702313611', context: context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Assets.icons.phone.svg(
                          colorFilter: ColorFilter.mode(
                            theme.colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppCard(
                    child: GestureDetector(
                      onTap: () => AppLaunch.sendEmail(
                        'dbolsunbekuulu@gmail.com',
                        context: context,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Assets.icons.email.svg(
                          colorFilter: ColorFilter.mode(
                            theme.colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppCard(
                    child: GestureDetector(
                      onTap: () => AppLaunch.sendTelegram('Duu1at', context: context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Assets.icons.telegram.svg(width: 20, height: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
