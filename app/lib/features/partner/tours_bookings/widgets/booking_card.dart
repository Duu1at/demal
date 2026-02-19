import 'package:app/features/partner/tours_bookings/widgets/contact_row.dart';
import 'package:app/features/partner/tours_bookings/widgets/detail_row.dart';
import 'package:app/utils/utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_repository/tour_repository.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(this.booking, {super.key});
  final TourBookingModel? booking;

  String _formatStatus(BookingStatusEnum? status, BuildContext context) {
    return switch (status) {
      BookingStatusEnum.pending => context.l10n.bookingStatusPendingShort,
      BookingStatusEnum.confirmed => context.l10n.bookingStatusConfirmedShort,
      BookingStatusEnum.paid => context.l10n.bookingStatusPaidShort,
      BookingStatusEnum.completed => context.l10n.bookingStatusCompletedShort,
      BookingStatusEnum.cancelled => context.l10n.bookingStatusCancelledShort,
      null => context.l10n.bookingStatusUnknownShort,
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

  String _formatCurrency(num? amount, BuildContext context) {
    if (amount == null) return '0 ${context.l10n.currencySom}';
    final formatter = NumberFormat('#,###', 'ru_RU');
    return '${formatter.format(amount)} ${context.l10n.currencySom}';
  }

  String _formatAmount(String? amount, BuildContext context) {
    if (amount == null || amount.isEmpty) return '0 ${context.l10n.currencySom}';
    final amountNum = int.tryParse(amount);
    return _formatCurrency(amountNum, context);
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

    final user = booking!.user;
    final paymentInfo = booking!.paymentInfo;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.primaryContainer,
                backgroundImage: (user?.imageUrl != null && user!.imageUrl!.isNotEmpty)
                    ? NetworkImage(user.imageUrl!)
                    : null,
                child: (user?.imageUrl == null || user!.imageUrl!.isEmpty)
                    ? Text(
                        (user?.fullName?.isNotEmpty ?? false)
                            ? user!.fullName![0].toUpperCase()
                            : (booking!.name?.isNotEmpty ?? false)
                            ? booking!.name![0].toUpperCase()
                            : '?',
                        style: textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.fullName ?? booking!.name ?? 'Unknown User',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    if (booking!.createdAt != null)
                      Text(
                        _formatDate(booking!.createdAt),
                        style: textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  _formatStatus(booking!.status, context),
                  style: textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const DividerHorisontal(padding: EdgeInsets.zero),

          if (booking!.phone != null || user?.phoneNumber != null || booking!.email != null || user?.email != null) ...[
            ContactRow(
              icon: Icons.phone_outlined,
              value: booking!.phone ?? user?.phoneNumber,
            ),
            const SizedBox(height: AppSpacing.xs),
            ContactRow(
              icon: Icons.email_outlined,
              value: booking!.email ?? user?.email,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppSpacing.md),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              children: [
                DetailRow(
                  label: context.l10n.seats,
                  value: '${booking!.seatsCount ?? 0}',
                  icon: Icons.event_seat_outlined,
                ),
                const SizedBox(height: AppSpacing.sm),
                const DividerHorisontal(padding: EdgeInsets.zero),
                const SizedBox(height: AppSpacing.sm),
                if (paymentInfo != null) ...[
                  if (paymentInfo.amount != null)
                    DetailRow(
                      label: context.l10n.amountPaid,
                      value: _formatCurrency(paymentInfo.amount, context),
                      icon: Icons.payments_outlined,
                      isBold: true,
                      valueColor: AppColors.green[40],
                    ),
                  if (paymentInfo.provider != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    DetailRow(
                      label: 'Provider',
                      value: paymentInfo.provider!,
                      icon: Icons.credit_card_outlined,
                    ),
                  ],
                ] else
                  DetailRow(
                    label: context.l10n.total,
                    value: _formatAmount(booking!.totalAmount, context),
                    icon: Icons.payments_outlined,
                    isBold: booking!.status == BookingStatusEnum.paid,
                    valueColor: booking!.status == BookingStatusEnum.paid ? AppColors.green[40] : null,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
