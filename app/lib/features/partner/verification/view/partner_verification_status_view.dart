import 'package:app/app/app.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

/// Screen shown when partner verification is pending approval
class PartnerVerificationStatusView extends StatelessWidget {
  const PartnerVerificationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статус верификации'),
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
                      'Ошибка загрузки статуса',
                      style: context.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppButton(
                      onPressed: () {

                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            );
          }

          final status = snapshot.data;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.hourglass_empty,
                    size: 80,
                    color: AppColors.orange,
                  ),
                  const SizedBox(height: AppSpacing.xlg),
                  Text(
                    'Заявка на рассмотрении',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Ваша заявка на верификацию отправлена и находится на проверке. Мы уведомим вас о результатах.',
                    style: context.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  if (status?.submittedAt != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.access_time, size: 20),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'Отправлено: ${_formatDate(status!.submittedAt!)}',
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xxlg),
                  AppButton(
                    onPressed: ()  {
                     
                    },
                    child: const Text('Обновить статус'),
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
