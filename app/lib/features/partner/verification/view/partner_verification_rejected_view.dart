import 'package:app/app/app.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';

class PartnerVerificationRejectedView extends StatelessWidget {
  const PartnerVerificationRejectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Верификация отклонена'),
        automaticallyImplyLeading: false,
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
                      'Ошибка загрузки данных',
                      style: context.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final status = snapshot.data;
          final adminComments = status?.adminComments ?? 'Документы не соответствуют требованиям';

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cancel_outlined,
                    size: 80,
                    color: AppColors.red,
                  ),
                  const SizedBox(height: AppSpacing.xlg),
                  Text(
                    'Заявка отклонена',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'К сожалению, ваша заявка на верификацию была отклонена.',
                    style: context.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline, size: 20),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              'Причина отклонения:',
                              style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          adminComments,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  if (status?.reviewedAt != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Проверено: ${_formatDate(status!.reviewedAt!)}',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xxlg),
                  AppButton(
                    onPressed: () {
                      context.go(AppRoutes.partnerVerification);
                    },
                    child: const Text('Подать заявку повторно'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextButton(
                    onPressed: () => context.read<AuthCubit>().logout(),
                    child: const Text('Выйти'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}
