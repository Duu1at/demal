import 'package:app/utils/utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    required this.controller,
    super.key,
    this.onChanged,
    this.hintText,
    this.label,
  });
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyLarge,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      validator: (val) => InputValidators.emailValidator(context, val),
      label: Text(
        label ?? '',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      prefixIcon: const Icon(Icons.email),
    );
  }
}
