import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.onFilterTap,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final void Function()? onFilterTap;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hintText: hintText ?? 'Поиск',
      onChanged: onChanged,
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Assets.icons.search.svg(
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
      suffixIcon: IconButton(
        onPressed: onFilterTap,
        icon: Assets.icons.settingsFilter.svg(
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      hintStyle: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: context.appColors.disabled),
    );
  }
}
