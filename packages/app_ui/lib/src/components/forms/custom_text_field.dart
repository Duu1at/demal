import 'package:app_ui/src/colors/app_input_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.inputFormatters,
    this.style,
    this.readOnly = false,
    this.keyboardType,
    this.enabled = true,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? label;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final TextInputType? keyboardType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.none,
      child: TextFormField(
        cursorColor: Theme.of(context).colorScheme.primary,
        style: style,
        focusNode: focusNode,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              width: 1,
              color: context.inputcolors.focused ?? Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputcolors.focused ?? Colors.transparent,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputcolors.disabled ?? Colors.transparent,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputcolors.focused ?? Colors.transparent,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputcolors.error ?? Colors.transparent,
              width: 1,
            ),
          ),
          fillColor: context.inputcolors.bckgr,
          filled: true,
          enabled: enabled,
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
