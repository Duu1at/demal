import 'package:api_client/api_client.dart';
import 'package:app/app/app.dart';
import 'package:app/core/core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:bookings_repository/bookings_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:storage/storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_repository/tour_repository.dart';
import 'package:upload_repository/upload_repository.dart';

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
            authRemoteDataSource: AuthRemoteDataSource(
              client: context.read<ApiClient>(),
              supabaseGoogleSignService: SupabaseGoogleSignService(
                googleSignIn: GoogleSignIn.instance,
                supabase: Supabase.instance,
                webClientId: dotenv.env['SUPABASE_WEB_CLIENT_ID']!,
                iosClientId: dotenv.env['SUPABASE_IOS_CLIENT_ID']!,
              ),
            ),
          ),
        ),
        RepositoryProvider<TourRepository>(
          create: (context) => TourRepositoryImpl(
            TourRemoteDataSource(context.read<ApiClient>()),
          ),
        ),
        RepositoryProvider<BookingsRepository>(
          create: (context) => BookingRepositoryImpl(
            BookingRemoteDataSource(context.read<ApiClient>()),
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepositoryImpl(
            remoteDataSource: ProfileRemoteDataSource(context.read<ApiClient>()),
            localDataSource: ProfileLocalDataSource(context.read<PreferencesStorage>()),
          ),
        ),
        RepositoryProvider<UploadRepository>(
          create: (context) => UploadRepositoryImpl(
            UploadRemoteDataSource(context.read<ApiClient>()),
          ),
        ),
        RepositoryProvider<ErrorHandler>(create: (context) => const BaseErrorHandler()),
        RepositoryProvider<ErrorHandleSnackBar>(create: (context) => const ErrorHandleSnackBar()),
        RepositoryProvider<ErrorHandleDialog>(create: (context) => const ErrorHandleDialog()),
        BlocProvider<VersionCheckCubit>(
          create: (context) => VersionCheckCubit(context.read<VersionCheckService>()),
        ),
        BlocProvider<AppThemeCubit>(
          create: (context) => AppThemeCubit(context.read<AppRepository>()),
        ),
        BlocProvider<AppLocaleCubit>(
          create: (context) => AppLocaleCubit(context.read<AppRepository>()),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            profileRepository: context.read<ProfileRepository>(),
            authRepository: context.read<AuthRepository>(),
          )..checkUser(),
        ),
        BlocProvider<ConnectivityCubit>(
          create: (context) => ConnectivityCubit(
            context.read<ConnectionChecker>(),
          ),
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
    _router = AppRouter.instance().router();
  }



  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: AppRouteNames.scaffoldMessengerKey,
        theme: context.watch<AppThemeCubit>().state.themeData,
        locale: context.watch<AppLocaleCubit>().state,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Demal',
        routerConfig: _router,
        builder: (context, child) {
          final localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
          if (localizations != null) {
            L10nService.instance.localizations = localizations;
          }
          return child ?? const SizedBox.shrink();
        },
      ),
    );
  }
}
