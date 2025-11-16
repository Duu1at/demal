import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';

class RoleRadioGroup extends StatelessWidget {
  const RoleRadioGroup({
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  final RoleEnum? groupValue;
  final ValueChanged<RoleEnum?> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<RoleEnum?>(
      groupValue: groupValue,
      onChanged: onChanged,
      child: const Column(
        children: [
          _RoleRedioWidget(
            key: Key('client'),
            isClient: true,
            title: 'Путешественник',
          ),
          _RoleRedioWidget(
            key: Key('partner'),
            isClient: false,
            title: 'Тур компания или гид',
          ),
        ],
      ),
    );
  }
}

class _RoleRedioWidget extends StatelessWidget {
  const _RoleRedioWidget({
    required this.isClient,
    this.title,
    super.key,
  });

  final bool isClient;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final group = RadioGroup.maybeOf<RoleEnum?>(context);
    final role = group?.groupValue;
    final selected = isClient ? role == RoleEnum.CLIENT : role == RoleEnum.PARTNER;
    final value = isClient ? RoleEnum.CLIENT : RoleEnum.PARTNER;

    return RadioListTile<RoleEnum?>(
      controlAffinity: ListTileControlAffinity.trailing,
      value: value,
      selected: selected,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
