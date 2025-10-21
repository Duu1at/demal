import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
    this.hintText = '(___) ___ ___',
    this.countryCode = '+996',
    this.inputFormatters,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? countryCode;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyLarge,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters,
      validator: validator,
      prefixIcon: SizedBox(
        height: 56,
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 8),
            Assets.images.flagKg.image(),
            Text(
              countryCode ?? '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24, child: DividerVertical()),
          ],
        ),
      ),
    );
  }
}
