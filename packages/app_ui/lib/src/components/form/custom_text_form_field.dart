import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.suffixText,
    this.counterText = '',
    this.hintText,
    this.labelText,
    this.hintTextStyle,
    this.validator,
    this.onChanged,
    this.onTapOutside,
    this.onFieldSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.onSaved,
    this.keyboardType,
    this.enabled,
    this.obscureText = false,
    this.autoFocus = false,
    this.addEmailValidation = false,
    this.alignLabelWithHint = true,
    this.readOnly = false,
    this.validationMinLength = 4,
    this.validationMaxLength = 255,
    this.maxLength = 255,
    this.minLines = 1,
    this.maxLines = 1,
    this.borderRadius = 16.0,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.textStyle,
    this.errorText,
    this.inputFormatters,
    this.textInputAction,
    this.shadowColor,
    this.elevation,
    this.autovalidateMode,
    this.autofillHints,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.initialValue,
  });

  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final String? suffixText;
  final String? counterText;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintTextStyle;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool obscureText;
  final bool autoFocus;
  final bool addEmailValidation;
  final bool alignLabelWithHint;
  final bool readOnly;
  final int validationMinLength;
  final int validationMaxLength;
  final int maxLength;
  final int minLines;
  final int maxLines;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final TextStyle? textStyle;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Color? shadowColor;
  final double? elevation;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: elevation ?? 0,
      borderRadius: BorderRadius.circular(borderRadius),
      child: TextFormField(
        onTap: onTap,
        onTapOutside: onTapOutside ?? (_) => FocusScope.of(context).unfocus(),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        onSaved: onSaved,
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        readOnly: readOnly,
        enabled: enabled,
        initialValue: initialValue,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        textInputAction: textInputAction ?? TextInputAction.next,
        textCapitalization: textCapitalization,
        style: textStyle ?? theme.textTheme.bodyLarge,
        maxLength: maxLength,
        validator: validator,
        autofillHints: autofillHints,
        cursorColor: theme.colorScheme.primary,
        cursorWidth: 1.5,
        autofocus: autoFocus,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: theme.colorScheme.surface,
          alignLabelWithHint: alignLabelWithHint,
          labelText: labelText,
          hintText: hintText,
          hintStyle: hintTextStyle ?? theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          errorText: errorText,
          counterText: counterText,
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffixIcon: suffixIcon,
          suffixText: suffixText,
          contentPadding: contentPadding,
          errorStyle: TextStyle(height: 1.2, color: theme.colorScheme.error),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Color(0xFF9C9FAF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Color(0xFF9C9FAF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Color(0xff9C9FAF), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
          ),
        ),
      ),
    );
  }
}
