import 'package:app_ui/colors/app_input_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
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
    this.contentPadding,
    this.maxLines = 1,
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
  final EdgeInsets? contentPadding;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextFormField(
        enabled: enabled,
        cursorColor: Theme.of(context).colorScheme.onSecondary,
        style: style,
        focusNode: focusNode,
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: contentPadding ?? EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputColors.primary ?? Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputColors.focused ?? Colors.transparent,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputColors.background ?? Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputColors.primary ?? Colors.transparent,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: context.inputColors.error ?? Colors.transparent,
              width: 0.8,
            ),
          ),
          fillColor: context.inputColors.background,
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
