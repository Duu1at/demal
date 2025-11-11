import 'package:flutter/material.dart';

class ReusableTextButton extends StatelessWidget {
  const ReusableTextButton({
    required this.onPressed,
    this.label,
    this.color,
    this.textStyle,
    this.icon,
    this.bgColor,
    this.padding,
    super.key,
  });

  final String? label;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;
  final Widget? icon;
  final Color? bgColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTextStyle = textTheme.labelLarge
        ?.copyWith(color: color ?? Theme.of(context).colorScheme.primary)
        .merge(textStyle);

    return TextButton.icon(
      onPressed: onPressed,

      style: TextButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: bgColor ?? Theme.of(context).colorScheme.surface,
      ),

      label: label == null ? const SizedBox.shrink() : Text(label!, style: buttonTextStyle),
      icon: icon,
    );
  }
}
