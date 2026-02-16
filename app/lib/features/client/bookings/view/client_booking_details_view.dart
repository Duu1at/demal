import 'package:app/features/client/client.dart';
import 'package:app/app/app.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_repository/tour_repository.dart';

class ClientBookingDetailsView extends StatefulWidget {
  const ClientBookingDetailsView(this.tour, {super.key});

  final TourModel tour;

  @override
  State<ClientBookingDetailsView> createState() => _ClientBookingDetailsViewState();
}

class _ClientBookingDetailsViewState extends State<ClientBookingDetailsView> {
  int guests = 1;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  int get _totalAmount => (widget.tour.price ?? 0) * guests;
  int get _paymentAmount {
    if (_totalAmount <= 0) return 0;
    return (_totalAmount * 0.1).ceil().clamp(1, _totalAmount);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitBooking() {
    context.read<ClientBookingDetailsBloc>().add(
      ClientBookingSubmitPressed(
        tourId: widget.tour.tourId,
        seatsCount: guests,
        name: _nameController.text,
        contact: _phoneController.text,
        fallbackPaymentAmount: _paymentAmount,
        itemName: widget.tour.title ?? 'Tour booking',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ClientBookingDetailsBloc, ClientBookingDetailsState>(
      listener: (context, state) async {
        if (state is ClientBookingDetailsValidationError) {
          AppSnackbar.showError(context: context, title: state.message);
          return;
        }
        if (state is ClientBookingDetailsFailure) {
          context.read<ErrorHandler>().handleError(state.error, context);
          return;
        }
        if (state is ClientBookingDetailsOpenPayment) {
          await context.pushNamed(
            AppRouteNames.clientFinikPayment,
            extra: state.args,
          );
        }
      },
      builder: (context, state) {
        final isSubmitting = state is ClientBookingDetailsSubmitting;
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
              _TotalPriceRow(total: _totalAmount, paymentAmount: _paymentAmount),
              const DividerHorisontal(),
              ContactForm(
                nameController: _nameController,
                emailController: _phoneController,
              ),
            ],
            columnChildren: [
              AppButton(
                onPressed: isSubmitting ? null : _submitBooking,
                child: Text(context.l10n.bookTour),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TotalPriceRow extends StatelessWidget {
  const _TotalPriceRow({required this.total, required this.paymentAmount});
  final int total;
  final int paymentAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
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
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'К оплате сейчас (10%)',
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              '$paymentAmount',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
