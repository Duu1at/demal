import 'package:app/features/client/client.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tour_repository/tour_repository.dart';

class ClientBookingDetailsView extends StatefulWidget {
  const ClientBookingDetailsView(this.tour, {super.key});

  final TourModel tour;

  @override
  State<ClientBookingDetailsView> createState() => _ClientBookingDetailsViewState();
}

class _ClientBookingDetailsViewState extends State<ClientBookingDetailsView> {
  int guests = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: Text(context.l10n.bookingDetailsTitle),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
      ),
      body: ScrollableForm(
        listViewChildren: [
          BookingHeaderCard(
            imageUrl: widget.tour.mainImageUrl ?? '',
            region: widget.tour.location,
            tourTitle: widget.tour.title,
            data: widget.tour.date,
            raiting: '${widget.tour.averageRating ?? 0} (${widget.tour.reviewsCount ?? 0})',
          ),
          const DividerHorisontal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.dateLabel, style: theme.textTheme.titleMedium),
              Text(
                widget.tour.date ?? '',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          if (widget.tour.availableSpots != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.availableSpots,
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  '${widget.tour.availableSpots}',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          GuestsSelector(
            count: guests,
            maxGuests: widget.tour.availableSpots,
            onChanged: (v) => setState(() => guests = v),
          ),
          const DividerHorisontal(),
          _TotalPriceRow(total: (widget.tour.price ?? 0) * guests),
          const DividerHorisontal(),
          ContactForm(
            nameController: TextEditingController(),
            emailController: TextEditingController(),
          ),
        ],
        columnChildren: const [],
      ),
    );
  }
}

class _TotalPriceRow extends StatelessWidget {
  const _TotalPriceRow({required this.total});
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${context.l10n.total} (СОМ)',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          total.toString(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
