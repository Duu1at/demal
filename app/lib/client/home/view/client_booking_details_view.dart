import 'package:app/client/home/widgets/booking_header_card.dart';
import 'package:app/client/home/widgets/contact_form.dart';
import 'package:app/client/home/widgets/guests_selecter.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientBookingDetailsView extends StatefulWidget {
  const ClientBookingDetailsView({super.key});

  @override
  State<ClientBookingDetailsView> createState() =>
      _ClientBookingDetailsViewState();
}

class _ClientBookingDetailsViewState extends State<ClientBookingDetailsView> {
  int guests = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: const Text('Booking Details'),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BookingHeaderCard(
              imageUrl:
                  'https://avatars.mds.yandex.net/i?id=0235fe3dc435f6213d89da66f423f0cb_l-10024314-images-thumbs&n=13',
              region: 'Chui',
              tourTitle: 'Ala-archa',
              data: '12.10.2025 5-февраль',
              raiting: '4.5 (675)',
            ),
            const DividerHorisontal(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data', style: theme.textTheme.titleMedium),
                Text(
                  'Jan 16 - Jan 20, 2025',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GuestsSelector(
              count: guests,
              onChanged: (v) => setState(() => guests = v),
            ),
            const DividerHorisontal(),

            const _TotalPriceRow(total: 1050),
            const DividerHorisontal(),
            ContactForm(
              nameController: TextEditingController(),
              emailController: TextEditingController(),
            ),
          ],
        ),
      ),
      floatingActionButton: AppButton(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        onPressed: () {},
        child: const Text('Оплатить 121312 с'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}



class _TotalPriceRow extends StatelessWidget {
  final int total;

  const _TotalPriceRow({required this.total});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total (СОМ)',
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
