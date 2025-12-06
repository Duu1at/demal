import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart'; // Import core for l10n
import 'package:flutter/material.dart';

class PartnerVerificationAgreement extends StatelessWidget {
  const PartnerVerificationAgreement({
    required this.isChecked,
    required this.onChanged,
    super.key,
  });

  final bool isChecked;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      value: isChecked,
      onChanged: (_) => onChanged.call(),
      subtitle: Text(
        context.l10n.termsAgreement,
      ),
    );
  }
}
