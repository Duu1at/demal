import 'package:app/app/cubit/app_theme_cubit.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/start/pages/onboarding_first_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: context.watch<AppThemeCubit>().state.themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      home: const OnboardingFirstView(),
    );
  }
}
