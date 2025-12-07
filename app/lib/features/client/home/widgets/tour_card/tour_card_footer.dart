import 'package:app/features/client/home/widgets/tour_card/tour_card_constants.dart';
import 'package:app/utils/tour_card/tour_card_utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TourCardFooter extends StatelessWidget {
  const TourCardFooter({this.price, this.onBookTap, super.key});

  final double? price;
  final VoidCallback? onBookTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildPrice(textTheme), _buildBookButton(textTheme)],
    );
  }

  Widget _buildPrice(TextTheme textTheme) {
    return Text(
      TourCardUtils.formatPrice(price),
      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBookButton(TextTheme textTheme) {
    return SizedBox(
      width: TourCardConstants.bookButtonWidth,
      height: TourCardConstants.bookButtonHeight,
      child: AppButton(
        onPressed: onBookTap,
        size: AppButtonSize.sm,
        child: Text(
          TourCardConstants.bookButtonText,
          style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
