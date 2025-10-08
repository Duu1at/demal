import 'package:app/app/cubit/app_cubit.dart';
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
      theme: context.watch<AppCubit>().state.theme.themeData,
      locale: context.watch<AppCubit>().state.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Demal',
      home: const OnboardingFirstView(),
    );
  }
}
