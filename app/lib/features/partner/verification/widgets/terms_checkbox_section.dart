import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TermsCheckboxSection extends StatelessWidget {
  const TermsCheckboxSection({
    required this.agreedToTerms,
    required this.onChanged,
    super.key,
  });

  final bool agreedToTerms;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: agreedToTerms,
          onChanged: (value) => onChanged(value ?? false),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Text(
              'Я согласен с условием использование и обработной персональных данных',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
