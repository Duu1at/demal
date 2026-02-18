import 'package:app/utils/utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:bookings_repository/bookings_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_repository/tour_repository.dart' show Currency;

class TicketCard extends StatelessWidget {
  const TicketCard({required this.booking, super.key});

  final BookingModel booking;

  String _formatStatus(BuildContext context, BookingStatusEnum? status) {
    return switch (status) {
      BookingStatusEnum.pending => context.l10n.statusPending,
      BookingStatusEnum.confirmed => context.l10n.statusConfirmed,
      BookingStatusEnum.paid => context.l10n.statusPaid,
      BookingStatusEnum.completed => context.l10n.statusCompleted,
      BookingStatusEnum.cancelled => context.l10n.statusCancelled,
      null => context.l10n.statusUnknown,
    };
  }

  Color _getStatusColor(BookingStatusEnum? status) {
    return switch (status) {
      BookingStatusEnum.paid => AppColors.green[30] ?? Colors.green,
      BookingStatusEnum.confirmed => AppColors.blue[30] ?? Colors.blue,
      BookingStatusEnum.completed => AppColors.green[40] ?? Colors.green.shade700,
      BookingStatusEnum.pending => AppColors.orange[30] ?? Colors.orange,
      BookingStatusEnum.cancelled => AppColors.red[30] ?? Colors.red,
      null => AppColors.gray[30] ?? Colors.grey,
    };
  }

  String _formatCurrency(num? amount) {
    if (amount == null) return '';
    final formatter = NumberFormat('#,###', 'ru_RU');
    return '${formatter.format(amount)} ${AppCurrencyFormatter.cuccancyType(Currency.KGS)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tour = booking.tour;
    final statusColor = _getStatusColor(booking.status);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: (tour?.mainImageUrl != null && tour!.mainImageUrl!.isNotEmpty)
                      ? Image.network(
                          tour.mainImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => ColoredBox(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: const Icon(Icons.image_not_supported_outlined),
                          ),
                        )
                      : ColoredBox(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.image_outlined),
                        ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            tour?.title ?? context.l10n.noTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (booking.status != null) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: statusColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              _formatStatus(context, booking.status),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (tour?.date != null)
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '${AppDateFormats.formatDdMMYyyy.format(tour!.date!)}${tour.time != null ? ' • ${tour.time}' : ''}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    if (tour?.location != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              tour!.location!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const DividerHorisontal(padding: EdgeInsets.zero),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _InfoColumn(
                  label: context.l10n.seats,
                  value: '${booking.seatsCount ?? 0}',
                ),
              ),
              if (booking.totalAmount != null)
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        context.l10n.total,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        _formatCurrency(booking.totalAmount),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (booking.paymentDetails?.provider != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${booking.paymentDetails!.provider} • ${booking.paymentDetails!.status ?? ''}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
