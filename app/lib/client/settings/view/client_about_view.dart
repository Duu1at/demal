import 'package:app/client/settings/widgets/tour_benefits.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ClientAboutView extends StatelessWidget {
  const ClientAboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(elevation: 0, title: const Text('О на')),
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
                'Последнее обновление: Декабрь 10, 2023',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.appColors.disabled,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const TourBenefits(),
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: DividerHorisontal()),
                  SizedBox(width: AppSpacing.sm),
                  Text('Contact Us'),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(child: DividerHorisontal()),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCard(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () =>
                          AppLaunch.makeCall('0702313611', context: context),
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
                      onTap: () =>
                          AppLaunch.sendTelegram('Duu1at', context: context),
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
