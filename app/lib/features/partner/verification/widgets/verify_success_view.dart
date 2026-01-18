import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';

class VerifySuccessView extends StatelessWidget {
  const VerifySuccessView(this.data, {super.key});

  final PartnerVerifyStatusModel? data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = data?.verificationStatus;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatusIcon(status),
            const SizedBox(height: AppSpacing.xlg),
            _buildStatusTitle(context, status),
            const SizedBox(height: AppSpacing.md),
            _buildStatusDescription(context, status, data?.adminComments),
            if (data?.submittedAt != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      context.l10n.submittedAt(data?.submittedAt ?? DateTime.now()),
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xxlg),
            if (status == PartnerVerifyStatusEnum.rejected)
              AppButton(
                onPressed: () => context.pushReplacementNamed(AppRouteNames.partnerVerification),
                child: Text(context.l10n.resubmitRequest),
              )
            else if (status == PartnerVerifyStatusEnum.verified)
              AppButton(
                onPressed: () => context.pushReplacementNamed(AppRouteNames.partner),
                child: Text(context.l10n.toMain),
              )
            else
              AppButton(
                onPressed: () {
                  context.read<VerifyStatusCubit>().getVerifyStatus();
                },
                child: Text(context.l10n.updateStatus),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(PartnerVerifyStatusEnum? status) {
    switch (status) {
      case PartnerVerifyStatusEnum.verified:
        return const Icon(Icons.check_circle_outline, size: 80, color: AppColors.green);
      case PartnerVerifyStatusEnum.rejected:
        return const Icon(Icons.cancel_outlined, size: 80, color: AppColors.red);
      case PartnerVerifyStatusEnum.pending:
      case PartnerVerifyStatusEnum.notStarted:
      case null:
        return const Icon(Icons.hourglass_empty, size: 80, color: AppColors.orange);
    }
  }

  Widget _buildStatusTitle(BuildContext context, PartnerVerifyStatusEnum? status) {
    String text;
    switch (status) {
      case PartnerVerifyStatusEnum.verified:
        text = context.l10n.verificationCongratulations;
      case PartnerVerifyStatusEnum.rejected:
        text = context.l10n.verificationRejectedTitle;
      case PartnerVerifyStatusEnum.pending:
        text = context.l10n.verificationPendingTitle;
      case PartnerVerifyStatusEnum.notStarted:
      case null:
        text = '';
    }
    return Text(
      text,
      style: context.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildStatusDescription(BuildContext context, PartnerVerifyStatusEnum? status, String? comments) {
    String text;
    Color? color;
    switch (status) {
      case PartnerVerifyStatusEnum.verified:
        text = context.l10n.verificationApprovedDesc;
      case PartnerVerifyStatusEnum.rejected:
        text = comments?.isNotEmpty ?? false
            ? context.l10n.verificationRejectedReason(comments!)
            : context.l10n.verificationRejectedDescDefault;
        color = AppColors.red;
      case PartnerVerifyStatusEnum.pending:
      case PartnerVerifyStatusEnum.notStarted:
      case null:
        text = context.l10n.verificationPendingDesc;
    }
    return Text(
      text,
      style: context.textTheme.bodyLarge?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
