import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outline, destructive, tonal }

enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.child,
    super.key,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.isLoading = false,
    this.fullWidth = true,
    this.leading,
    this.trailing,
    this.style,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.margin,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool fullWidth;
  final Widget? leading;
  final Widget? trailing;
  final ButtonStyle? style;
  final String? semanticLabel;
  final bool autofocus;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final p = switch (size) {
      AppButtonSize.sm => const _SizePreset(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 12),
        textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      AppButtonSize.md => const _SizePreset(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 16),
        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      ),
      AppButtonSize.lg => const _SizePreset(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 20),
        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
      ),
    };

    Color resolveBg(Set<WidgetState> states) {
      final disabled = states.contains(WidgetState.disabled);
      final pressed = states.contains(WidgetState.pressed);
      final hovered = states.contains(WidgetState.hovered);

      switch (variant) {
        case AppButtonVariant.primary:
          if (disabled) return colors.primary;
          // if (pressed) return colors.primaryContainer;
          // if (hovered) return Color.alphaBlend(colors.onPrimary.withValues(alpha: 0.08), colors.primary);
          return colors.primary;
        case AppButtonVariant.secondary:
          if (disabled) return colors.secondary.withValues(alpha: 0.2);
          if (pressed) return colors.secondaryContainer;
          if (hovered) return Color.alphaBlend(colors.onSecondary.withValues(alpha: 0.08), colors.secondary);
          return colors.secondary;
        case AppButtonVariant.tonal:
          if (disabled) return colors.secondaryContainer.withValues(alpha: 0.4);
          if (pressed) return colors.secondaryContainer.withValues(alpha: 0.9);
          return colors.secondaryContainer;
        case AppButtonVariant.outline:
          return Colors.transparent;
        case AppButtonVariant.destructive:
          final base = colors.error;
          if (disabled) return base.withValues(alpha: 0.28);
          if (pressed) return colors.errorContainer;
          if (hovered) return Color.alphaBlend(colors.onError.withValues(alpha: 0.08), base);
          return base;
      }
    }

    Color resolveFg(Set<WidgetState> states) {
      final disabled = states.contains(WidgetState.disabled);
      switch (variant) {
        case AppButtonVariant.primary:
        case AppButtonVariant.secondary:
        case AppButtonVariant.destructive:
          return disabled ? colors.onSurface.withValues(alpha: 0.38) : colors.onPrimary;
        case AppButtonVariant.tonal:
          return disabled ? colors.onSurface.withValues(alpha: 0.38) : colors.onSecondaryContainer;
        case AppButtonVariant.outline:
          return disabled ? colors.onSurface.withValues(alpha: 0.38) : colors.primary;
      }
    }

    OutlinedBorder resolveShape(Set<WidgetState> states) {
      const radius = 16.0;
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
    }

    BorderSide? resolveBorder(Set<WidgetState> states) {
      if (variant != AppButtonVariant.outline) return null;
      final disabled = states.contains(WidgetState.disabled);
      return BorderSide(color: disabled ? colors.outlineVariant : colors.outline, width: 1.2);
    }

    final baseStyle = ButtonStyle(
      minimumSize: WidgetStateProperty.all(Size(fullWidth ? double.infinity : 0, p.height)),
      maximumSize: WidgetStateProperty.all(Size(double.infinity, p.height)),
      padding: WidgetStateProperty.all(p.padding),
      shape: WidgetStateProperty.resolveWith(resolveShape),
      side: WidgetStateProperty.resolveWith(resolveBorder),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (variant == AppButtonVariant.outline || variant == AppButtonVariant.tonal) return 0;
        if (states.contains(WidgetState.pressed)) return 0;
        return 1;
      }),
      backgroundColor: WidgetStateProperty.resolveWith(resolveBg),
      foregroundColor: WidgetStateProperty.resolveWith(resolveFg),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.white.withValues(alpha: 0.06);
        }
        return null;
      }),
      textStyle: WidgetStateProperty.all(theme.textTheme.labelLarge?.merge(p.textStyle) ?? p.textStyle),
      alignment: Alignment.center,
      enableFeedback: true,
      visualDensity: VisualDensity.standard,
    ).merge(style);

    final effectiveOnPressed = (isLoading || onPressed == null) ? null : onPressed;

    final content = _ButtonContent(
      leading: leading,
      trailing: trailing,
      isLoading: isLoading,
      fgResolver: resolveFg,
      isEnabled: effectiveOnPressed != null,
      child: child,
    );

    final Widget button = switch (variant) {
      AppButtonVariant.outline => OutlinedButton(
        onPressed: effectiveOnPressed,
        autofocus: autofocus,
        focusNode: focusNode,
        style: baseStyle,
        child: content,
      ),
      AppButtonVariant.primary ||
      AppButtonVariant.secondary ||
      AppButtonVariant.destructive ||
      AppButtonVariant.tonal => ElevatedButton(
        onPressed: effectiveOnPressed,
        autofocus: autofocus,
        focusNode: focusNode,
        style: baseStyle,
        child: content,
      ),
    };

    return Semantics(
      button: true,
      enabled: effectiveOnPressed != null,
      label: semanticLabel,
      child: Padding(padding: margin ?? EdgeInsets.zero, child: button),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.child,
    required this.isLoading,
    required this.fgResolver,
    required this.isEnabled,
    this.leading,
    this.trailing,
  });

  final Widget child;
  final bool isEnabled;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final Color Function(Set<WidgetState>) fgResolver;

  @override
  Widget build(BuildContext context) {
    final states = <WidgetState>{};
    if (!isEnabled) states.add(WidgetState.disabled);
    final fg = fgResolver(states);
    final base = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          IconTheme(
            data: IconThemeData(color: fg, size: 20),
            child: leading!,
          ),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: DefaultTextStyle.merge(
            style: TextStyle(color: fg, fontWeight: FontWeight.w700),
            child: child is Text
                ? Text(
                    (child as Text).data ?? '',
                    style: (child as Text).style?.copyWith(color: fg) ?? TextStyle(color: fg),
                    textAlign: (child as Text).textAlign,
                    maxLines: (child as Text).maxLines,
                    overflow: (child as Text).overflow,
                  )
                : child,
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          IconTheme(
            data: IconThemeData(color: fg, size: 20),
            child: trailing!,
          ),
        ],
      ],
    );

    if (!isLoading) return base;

    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: 0, child: base),
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2.2, valueColor: AlwaysStoppedAnimation<Color>(fg)),
        ),
      ],
    );
  }
}

class _SizePreset {
  const _SizePreset({required this.height, required this.padding, required this.textStyle});

  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
}
