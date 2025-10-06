import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.errorText,
    this.initialValue,
    this.hintText,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? errorText;
  final String? initialValue;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTextColor = enabled == false
        ? theme.hintColor
        : errorText != null
        ? theme.colorScheme.error
        : theme.colorScheme.onSurface;

    final Widget prefixWidget = SizedBox(
      width: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Assets.images.flagKg.image(width: 24, height: 24),
          const SizedBox(width: AppSpacing.sm),
          const Text('+996', style: TextStyle(fontSize: 14)),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            height: 24,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: enabled == false ? theme.hintColor.withValues(alpha: .5) : const Color(0xFFD1D3DB),
            ),
          ),
        ],
      ),
    );

    return CustomTextFormField(
      textStyle: TextStyle(fontSize: 14, color: inputTextColor),
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: TextInputType.phone,
      contentPadding: EdgeInsets.zero,
      enabled: enabled,
      errorText: errorText,
      prefixIcon: Padding(padding: const EdgeInsets.only(left: 16, right: 8), child: prefixWidget),
      hintText: hintText,
    );
  }
}
