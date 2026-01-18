import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_repository/tour_repository.dart';

class ToursBookingsListContent extends StatelessWidget {
  const ToursBookingsListContent(this.bookings, {super.key});
  final ToursBookingsModel bookings;

  String _formatAmount(int amount, BuildContext context) {
    final formatter = NumberFormat('#,###', 'ru_RU');
    return '${formatter.format(amount)} ${context.l10n.currencySom}';
  }

  int _calculatePaidAmount() {
    if (bookings.bookings == null) return 0;
    return bookings.bookings!.where((booking) => booking.status == BookingStatusEnum.paid).fold<int>(
      0,
      (sum, booking) {
        if (booking.totalAmount == null || booking.totalAmount!.isEmpty) {
          return sum;
        }
        final amount = int.tryParse(booking.totalAmount!);
        return sum + (amount ?? 0);
      },
    );
  }

  int _calculatePaidParticipants() {
    if (bookings.bookings == null) return 0;
    return bookings.bookings!
        .where((booking) => booking.status == BookingStatusEnum.paid)
        .fold<int>(
          0,
          (sum, booking) => sum + (booking.seatsCount ?? 0),
        );
  }

  @override
  Widget build(BuildContext context) {
    final paidParticipants = _calculatePaidParticipants();
    final paidAmount = _calculatePaidAmount();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.sm),
          StatCard(
            icon: Icons.check_circle_outline,
            label: context.l10n.participantsCount,
            value: '$paidParticipants',
            color: AppColors.blue[30] ?? Colors.blue,
          ),
          const SizedBox(height: AppSpacing.sm),
          StatCard(
            icon: Icons.payments_outlined,
            label: context.l10n.amountPaid,
            value: _formatAmount(paidAmount, context),
            color: AppColors.green[40] ?? Colors.green.shade700,
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: (bookings.bookings?.isNotEmpty ?? false)
                ? ListView.separated(
                    itemBuilder: (_, index) => BookingCard(bookings.bookings?[index]),
                    separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                    itemCount: bookings.bookings?.length ?? 0,
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.confirmation_number_outlined,
                          size: 64,
                        ),
                        Text(
                          context.l10n.noBookingsForTour,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
