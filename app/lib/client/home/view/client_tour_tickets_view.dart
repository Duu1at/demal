import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ClientTourTicketsView extends StatelessWidget {
  const ClientTourTicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      bgImageTop: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Мои билеты', style: theme.textTheme.titleLarge),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  AppCard(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Поход в Ала-Арчу',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            RichText(
                              text: TextSpan(
                                text: 'Дата и время: ',
                                style: theme.textTheme.bodyMedium?.copyWith(),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '20 октября 2025, 08:00',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            RichText(
                              text: TextSpan(
                                text: 'Организатор: ',
                                style: theme.textTheme.bodyMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Эмиль Асанов',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            RichText(
                              text: TextSpan(
                                text: 'Телефон: ',
                                style: theme.textTheme.bodyMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '+996 555 123 456',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            RichText(
                              text: TextSpan(
                                text: 'Количество мест: ',
                                style: theme.textTheme.bodyMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '2',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            RichText(
                              text: TextSpan(
                                text: 'Место сбора: ',
                                style: theme.textTheme.bodyMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '2г. Бишкек, ул. Ахунбаева 112',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            RichText(
                              text: TextSpan(
                                text: 'Статус: ',
                                style: theme.textTheme.bodyMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '"Подтверждено"',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Итоговая сумма: 2400 сом',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.sm),
          itemCount: 10,
        ),
      ),
    );
  }
}
