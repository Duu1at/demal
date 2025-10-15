import 'package:app/app/cubits/app_cubit.dart';
import 'package:app/app/cubits/app_settings/app_locale_cubit.dart';
import 'package:app/app/cubits/app_settings/app_theme_cubit.dart';
import 'package:app/core/core.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DemalApp extends StatefulWidget {
  const DemalApp({super.key});

  @override
  State<DemalApp> createState() => _DemalAppState();
}

class _DemalAppState extends State<DemalApp> {
  late final GoRouter _router;

  @override
  void initState() {
    _router = AppRouter.instance(isNewUser: true, role: Role.client
    ).router();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        themeMode: ThemeMode.system,
        theme: context.watch<AppThemeCubit>().state.themeData,
        locale: context.watch<AppLocaleCubit>().state,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Demal',
        routerConfig: _router,
      ),
    );
  }
}
