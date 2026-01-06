import 'package:app/app/app.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';

class PartnerVerificationStatusView extends StatelessWidget {
  const PartnerVerificationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статус верификации'),
        leading: IconButton(
          onPressed: () {
            context.goNamed(AppRouteNames.settings);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: FutureBuilder<PartnerVerifyStatusModel>(
        future: context.read<ProfileRepository>().getPartnerVerifyStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.red,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Ошибка загрузки статуса',
                      style: context.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppButton(
                      onPressed: () {
                        (context as Element).markNeedsBuild();
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            );
          }

          final statusModel = snapshot.data;
          final status = statusModel?.verificationStatus;

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
                  _buildStatusDescription(context, status, statusModel?.adminComments),

                  if (statusModel?.submittedAt != null) ...[
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
                            'Отправлено: ${_formatDate(statusModel!.submittedAt!)}',
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.xxlg),

                  if (status == PartnerVerifyStatusEnum.rejected)
                    AppButton(
                      onPressed: () => context.goNamed(AppRouteNames.partnerVerification),
                      child: const Text('Заново отправить заявку'),
                    )
                  else if (status == PartnerVerifyStatusEnum.verified)
                    AppButton(
                      onPressed: () => context.goNamed(AppRouteNames.partner),
                      child: const Text('Перейти на главную'),
                    ),
                ],
              ),
            ),
          );
        },
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
        text = 'Ваша заявка на верификацию отправлена и находится на проверке.';
    }
    return Text(
      text,
      style: context.textTheme.bodyLarge?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}
