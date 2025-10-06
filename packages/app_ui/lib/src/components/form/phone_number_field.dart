import 'package:app_ui/src/generated/assets.gen.dart';
import 'package:flutter/material.dart';

enum PhoneFieldState { normal, focused, disabled, error, errorFocused, success, successFocused }

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    this.controller,
    this.onChanged,
    this.state = PhoneFieldState.normal,
    this.countryCode = '+996',
    this.hintText = '000 000 000',
    this.validator,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final PhoneFieldState state;
  final String countryCode;
  final String hintText;
  final String? Function(String?)? validator;

  Color _borderColor(BuildContext context) {
    switch (state) {
      case PhoneFieldState.focused:
        return const Color(0xFF9C9FAF);
      case PhoneFieldState.error:
      case PhoneFieldState.errorFocused:
        return Colors.red;
      case PhoneFieldState.success:
      case PhoneFieldState.successFocused:
        return Colors.green;
      default:
        return Colors.grey.shade400;
    }
  }

  Color _backgroundColor() {
    switch (state) {
      case PhoneFieldState.disabled:
        return Colors.grey.shade200;
      case PhoneFieldState.errorFocused:
      case PhoneFieldState.successFocused:
        return Colors.transparent;
      default:
        return Colors.white;
    }
  }

  Color _textColor(BuildContext context) {
    if (state == PhoneFieldState.disabled || state == PhoneFieldState.normal) {
      return Colors.grey.shade400;
    }
    if (state == PhoneFieldState.error || state == PhoneFieldState.errorFocused) {
      return Colors.red;
    }
    if (state == PhoneFieldState.success || state == PhoneFieldState.successFocused) {
      return Colors.green;
    }
    return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _borderColor(context);
    final textColor = _textColor(context);

    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
        boxShadow:
            state == PhoneFieldState.focused ||
                state == PhoneFieldState.errorFocused ||
                state == PhoneFieldState.successFocused
            ? [BoxShadow(color: borderColor.withValues(alpha: .3), blurRadius: 6, offset: const Offset(0, 2))]
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.only(right: 8), child: Assets.images.flagKg.image(width: 24, height: 24)),
          Text(countryCode, style: TextStyle(color: textColor, fontSize: 14)),
          SizedBox(
            height: 24,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: VerticalDivider(width: 1, thickness: 1, color: _borderColor(context)),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              enabled: state != PhoneFieldState.disabled,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: textColor, fontSize: 14),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: textColor),
                border: InputBorder.none,
              ),
              validator: validator,
              cursorColor: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
