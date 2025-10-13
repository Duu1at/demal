import 'package:app/app/cubit/app_cubit.dart';
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
    _router = AppRouter.instance(isNewUser: false, role: Role.partner).router();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        themeMode: ThemeMode.system,
        theme: context.watch<AppCubit>().state.theme.themeData,
        locale: context.watch<AppCubit>().state.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Demal',
        routerConfig: _router,
      ),
    );
  }
}
