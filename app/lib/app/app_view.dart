import 'package:app/app/cubits/app_settings/app_locale_cubit.dart';
import 'package:app/app/cubits/app_settings/app_theme_cubit.dart';
import 'package:app/app/cubits/auth/auth_cubit.dart';
import 'package:app/app/router/app_router.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;
  @override
  void initState() {
    final authCubit = context.read<AuthCubit>();
    _router = AppRouter.instance().router(authCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
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
