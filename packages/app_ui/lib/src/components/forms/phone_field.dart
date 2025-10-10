import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
    this.hintText = '000 000 000',
    this.countryCode = '+996',
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyMedium,
      onChanged: onChanged,
      validator: validator,
      prefixIcon: SizedBox(
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 8),
            Assets.images.flagKg.image(),
            Text(
              countryCode ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24, child: DividerVertical()),
          ],
        ),
      ),
    );
  }
}
