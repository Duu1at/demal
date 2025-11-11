import 'package:app/app/cubits/app_locale_cubit/app_locale_cubit.dart';
import 'package:app/app/cubits/app_theme_cubit/app_theme_cubit.dart';
import 'package:app/app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/app/router/app_router.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:client_tour_repository/client_tour_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:storage/storage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepositoryImpl(
            AppLocalDataSourceImpl(storage: context.read<PreferencesStorage>()),
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            authLocalDataSource: AuthLocalDataSource(context.read<PreferencesStorage>()),
            authRemoteDataSource: AuthRemoteDataSource(context.read<RemoteClient>()),
          ),
        ),

        RepositoryProvider<ClientTourRepository>(
          create: (context) => ClientTourRepositoryImpl(
            ClientTourRemoteDataSource(context.read<RemoteClient>()),
          ),
        ),
        BlocProvider<AppThemeCubit>(
          create: (context) => AppThemeCubit(context.read<AppRepository>()),
        ),
        BlocProvider<AppLocaleCubit>(
          create: (context) => AppLocaleCubit(context.read<AppRepository>()),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(context.read<AuthRepository>())..checkAuthStatus(),
        ),
      ],
      child: const DemalApp(),
    );
  }
}

class DemalApp extends StatefulWidget {
  const DemalApp({super.key});

  @override
  State<DemalApp> createState() => _DemalAppState();
}

class _DemalAppState extends State<DemalApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final authCubit = context.read<AuthCubit>();
    _router = AppRouter.instance().router(authCubit);
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
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
