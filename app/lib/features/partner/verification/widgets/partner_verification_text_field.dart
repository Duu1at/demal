import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PartnerVerificationTextField extends StatelessWidget {
  const PartnerVerificationTextField({
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters = const <TextInputFormatter>[],
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      hintText: hintText,
      onChanged: onChanged,
    );
  }
}
