import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tour_repository/tour_repository.dart';

class ToursBookingsListContent extends StatelessWidget {
  const ToursBookingsListContent(this.bookings, {super.key});
  final ToursBookingsModel bookings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
