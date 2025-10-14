import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLocaleCubit extends Cubit<Locale> {
  AppLocaleCubit(this.appThemeRepository)
    : super(appThemeRepository.getInitialLocale());

  final AppRepository appThemeRepository;

  Future<void> changeLocale({required Locale locale}) async {
    await appThemeRepository.saveLocale(locale);
    emit(locale);
  }
}
