import 'package:app/app/cubits/app_settings/app_theme_cubit.dart';
import 'package:app/welcome/welcome.dart'; 
import 'package:app_ui/app_ui.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SettingsChangeMixin<T extends StatefulWidget> on State<T> {
  void changeLocale() {
    BottomSheets.showModalSettingsSheet(
      showDragHandle: true,
      backgroundColor: context.appColors.bgCard,
      context: context,
      child: const LocaleSettingsSheet(), 
    );
  }

  Future<bool> changeTheme() async {
    final result = await BottomSheets.showModalSettingsSheet(
      showDragHandle: true,
      backgroundColor: context.appColors.bgCard,
      context: context,
      child: const ThemeSelectorSheet(),
    );
    if (result == null && context.mounted) {
        return context.read<AppThemeCubit>().state.isDark;
    }
    return result as bool;
  }
}