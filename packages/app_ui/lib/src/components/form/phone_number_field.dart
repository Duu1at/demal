import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key, this.controller, this.onChanged, this.validator});

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textStyle: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: TextInputType.phone,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      prefix: SizedBox(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Assets.images.flagKg.image(width: 24, height: 24),
            const Text('+996', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 24, child: VerticalDivider(width: 1, thickness: 1, color: Color(0xFFD1D3DB))),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
