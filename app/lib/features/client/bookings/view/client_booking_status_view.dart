import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ClientBookingStatusView extends StatelessWidget {
  const ClientBookingStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.succesStatus.image(),
          const SizedBox(height: AppSpacing.xl),
          Text(
            context.l10n.tourBooked,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxlg),
            child: Text(context.l10n.myTour),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
