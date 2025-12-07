import 'package:app/utils/formatter/currency_formatter.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PartnerTourCardPrice extends StatelessWidget {
  const PartnerTourCardPrice({
    required this.price,
    this.currency,
    super.key,
  });

  final int? price;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    if (price == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final currencySymbol = AppCurrencyFormatter.cuccancyType(currency ?? 'KGS');
    final formattedPrice = NumberFormat('#,###', 'ru').format(price);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.monetization_on,
            size: 18,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.xs / 2),
          Text(
            '$formattedPrice $currencySymbol',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
