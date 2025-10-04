import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.controller,
    this.label,
    this.validator,
    this.keyboardType,
    this.enabled,
    this.textStyle,
    this.onChanged,
    this.onTapOutside,
    this.onTap,
    this.onFieldSubmitted,
    this.hintText,
    this.hintTextStyle,
    this.inputFormatters,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 255,
    this.obscureText = false,
    this.readOnly = false,
    this.alignLabelWithHint = true,
    this.addEmailValidation = false,
    this.borderRadius = 8.0,
    this.contentPadding = 12.0,
    this.counterText = '',
    this.suffixIcon,
    this.suffixText,
    this.autoFocus = false,
    this.textInputAction,
    this.errorText,
    super.key,
    this.validationMinLength = 4,
    this.validationMaxLength = 255,
    this.shadowColor,
    this.elevation,
    this.prefixIcon,
    this.autovalidateMode,
    this.autofillHints,
    this.focusNode,
  });

  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? suffixText;
  final String? label;
  final String? counterText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? obscureText;
  final bool? autoFocus;
  final bool? addEmailValidation;
  final bool? alignLabelWithHint;
  final bool? readOnly;
  final int? validationMinLength;
  final int? validationMaxLength;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double? borderRadius;
  final double? contentPadding;
  final TextStyle? textStyle;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Color? shadowColor;
  final double? elevation;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shadowColor: shadowColor ?? theme.colorScheme.secondary.withValues(alpha: 0.1),
      elevation: elevation ?? 13,
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: TextFormField(
        onTap: onTap,
        onTapOutside:
            onTapOutside ??
            (event) {
              FocusScope.of(context).unfocus();
            },
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        maxLines: maxLines,
        readOnly: readOnly!,
        enabled: enabled,
        obscureText: obscureText!,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        textInputAction: textInputAction ?? TextInputAction.next,
        style: textStyle,
        maxLength: maxLength,
        validator: validator,
        autofillHints: autofillHints,
        focusNode: focusNode,
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: theme.textTheme.bodyLarge?.copyWith(fontSize: 12),
          labelStyle: theme.primaryTextTheme.bodyLarge,
          border: InputBorder.none,
          contentPadding: contentPadding != null
              ? EdgeInsets.all(contentPadding!)
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          hintText: hintText,
          labelText: label,
          errorText: errorText,
          counterText: counterText,
          hintStyle: hintTextStyle,
          suffixIcon: suffixIcon,
          suffixText: suffixText,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}
