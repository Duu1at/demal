import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.hintStyle,
    this.focusNode,
    this.label,
    this.labelStyle,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? label;
  final TextStyle? labelStyle;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          label: label,
          labelStyle: labelStyle,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffix: suffix,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
