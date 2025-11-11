import 'package:app/app/cubits/app_theme_cubit/app_theme_cubit.dart';
import 'package:app/widgets/locale_settings_sheet.dart';
import 'package:app/widgets/theme_settings_sheet.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SettingsChangeMixin<T extends StatefulWidget> on State<T> {
  Future<void> changeLocale() async {
    await BottomSheets.showModalSettingsSheet<void>(
      showDragHandle: true,
      backgroundColor: context.appColors.bgCard,
      context: context,
      child: const LocaleSettingsSheet(),
    );
  }

  Future<bool?> changeTheme() async {
    final result = await BottomSheets.showModalSettingsSheet<bool>(
      showDragHandle: true,
      backgroundColor: context.appColors.bgCard,
      context: context,
      child: const ThemeSelectorSheet(),
    );

    if (mounted && result == null) {
      return context.read<AppThemeCubit>().state.isDark;
    }
    
    return result;
  }
}
