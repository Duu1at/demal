
import 'package:app/features/features.dart';
import 'package:app/utils/formatter/formatter.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_repository/tour_repository.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(this.booking, {super.key});
  final TourBookingModel? booking;

  String _formatStatus(BookingStatusEnum? status) {
    return switch (status) {
      BookingStatusEnum.pending => 'Ожидает',
      BookingStatusEnum.confirmed => 'Подтверждено',
      BookingStatusEnum.paid => 'Оплачено',
      BookingStatusEnum.completed => 'Завершено',
      BookingStatusEnum.cancelled => 'Отменено',
      null => 'Неизвестно',
    };
  }

  Color _getStatusColor(BookingStatusEnum? status, BuildContext context) {
    return switch (status) {
      BookingStatusEnum.paid => AppColors.green[30] ?? Colors.green,
      BookingStatusEnum.confirmed => AppColors.blue[30] ?? Colors.blue,
      BookingStatusEnum.completed => AppColors.green[40] ?? Colors.green.shade700,
      BookingStatusEnum.pending => AppColors.orange[30] ?? Colors.orange,
      BookingStatusEnum.cancelled => AppColors.red[30] ?? Colors.red,
      null => AppColors.gray[30] ?? Colors.grey,
    };
  }

  String _formatAmount(String? amount) {
    if (amount == null || amount.isEmpty) return '0 сом';
    final amountNum = int.tryParse(amount);
    if (amountNum == null) return '$amount сом';
    final formatter = NumberFormat('#,###', 'ru_RU');
    return '${formatter.format(amountNum)} сом';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return AppDateFormats.formatDdMMYyyyHHmm.format(date);
  }

  @override
  Widget build(BuildContext context) {
    if (booking == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final statusColor = _getStatusColor(booking!.status, context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (booking!.name != null && booking!.name!.isNotEmpty)
                      Text(
                        booking!.name!,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (booking!.createdAt != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _formatDate(booking!.createdAt),
                        style: textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  _formatStatus(booking!.status),
                  style: textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const DividerHorisontal(padding: EdgeInsets.zero),
          if (booking!.email != null && booking!.email!.isNotEmpty)
            InfoRow(
              icon: Icons.email_outlined,
              label: 'Email',
              value: booking!.email!,
            ),
          if (booking!.user?.phoneNumber != null && booking!.user!.phoneNumber!.isNotEmpty) ...[
            if (booking!.email != null && booking!.email!.isNotEmpty) const SizedBox(height: AppSpacing.sm),
            InfoRow(
              icon: Icons.phone_outlined,
              label: 'Телефон',
              value: booking!.user!.phoneNumber!,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: InfoChip(
                  icon: Icons.event_seat_outlined,
                  label: 'Мест',
                  value: '${booking!.seatsCount ?? 0}',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        _formatAmount(booking!.totalAmount),
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
