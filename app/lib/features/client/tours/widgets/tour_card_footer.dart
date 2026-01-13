import 'package:app/utils/tour_card/tour_card_utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TourCardFooter extends StatelessWidget {
  const TourCardFooter({this.price, this.onBookTap, super.key});

  final int? price;
  final VoidCallback? onBookTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildPrice(textTheme), _buildBookButton(context, textTheme)],
    );
  }

  Widget _buildPrice(TextTheme textTheme) {
    return Text(
      TourCardUtils.formatPrice(price),
      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBookButton(BuildContext context, TextTheme textTheme) {
    return SizedBox(
      width: 130,
      height: 32,
      child: AppButton(
        onPressed: onBookTap,
        size: AppButtonSize.sm,
        child: Text(
          context.l10n.bookTour,
          style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
