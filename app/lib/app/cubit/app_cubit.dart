import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.appThemeRepository)
    : super(
        AppState(
          theme: appThemeRepository.getInitialThemeState(),
          locale: appThemeRepository.getInitialLocale(),
        ),
      );

  final AppRepository appThemeRepository;

  Future<void> changeMode({required bool isDark}) async {
    await appThemeRepository.saveTheme(isDark);
    emit(state.copyWith(theme: isDark ? AppDarkTheme() : AppLightTheme()));
  }

  Future<void> changeLocale({required Locale locale}) async {
    await appThemeRepository.saveLocale(locale);
    emit(state.copyWith(locale: locale));
  }

  Future<void> changeRole({required Role role}) async {
    emit(state.copyWith(role: role));
  }
}
