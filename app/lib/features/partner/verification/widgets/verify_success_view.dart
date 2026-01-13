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
                      'Отправлено: ${_formatDate(data?.submittedAt)}',
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
                child: const Text('Заново отправить заявку'),
              )
            else if (status == PartnerVerifyStatusEnum.verified)
              AppButton(
                onPressed: () => context.pushReplacementNamed(AppRouteNames.partner),
                child: const Text('Перейти на главную'),
              )
            else
              AppButton(
                onPressed: () {
                  context.read<VerifyStatusCubit>().getVerifyStatus();
                },
                child: const Text('Обновить статус'),
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
        text = 'Поздравляем!';
      case PartnerVerifyStatusEnum.rejected:
        text = 'Заявка отклонена';
      case PartnerVerifyStatusEnum.pending:
        text = 'Заявка на рассмотрении';
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
        text = 'Ваша заявка одобрена. Теперь вы стали партнером и можете создавать туры.';
      case PartnerVerifyStatusEnum.rejected:
        text = comments?.isNotEmpty ?? false
            ? 'Причина отклонения: $comments'
            : 'Ваша заявка была отклонена модератором. Пожалуйста, исправьте данные и отправьте снова.';
        color = AppColors.red;
      case PartnerVerifyStatusEnum.pending:
      case PartnerVerifyStatusEnum.notStarted:
      case null:
        text =
            'Ваша заявка на верификацию отправлена и находится на проверке. Рассмотрение занимает от 1 до 2 рабочих дней.';
    }
    return Text(
      text,
      style: context.textTheme.bodyLarge?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }

  String _formatDate(DateTime? date) {
    return '${date?.day}.${date?.month}.${date?.year}';
  }
}
