import 'package:app/app/cubit/app_cubit.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class RoleRedioWidget extends StatelessWidget {
  const RoleRedioWidget({
    required this.role,
    this.isClient = true,
    this.onChanged,
    this.title,
    super.key,
  });
  final Role role;
  final void Function(Role?)? onChanged;
  final String? title;
  final bool isClient;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return RadioListTile<Role>(
      controlAffinity: ListTileControlAffinity.trailing,
      value: isClient ? Role.client : Role.partner,
      groupValue: role,
      onChanged: onChanged,
      secondary: isClient
          ? Assets.icons.infoCircle.svg(
              colorFilter: ColorFilter.mode(
                selected ? colorScheme.primary : colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            )
          : Assets.icons.tickCircle.svg(
              colorFilter: ColorFilter.mode(
                selected ? colorScheme.primary : colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
      title: Text(
        title ?? '',
        style: textTheme.titleMedium?.copyWith(
          color: selected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  bool get selected {
    return isClient ? role == Role.client : role == Role.partner;
  }
}
