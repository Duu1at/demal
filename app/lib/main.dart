import 'package:app/app/app_view.dart';
import 'package:app/app/cubits/app_settings/app_locale_cubit.dart';
import 'package:app/app/cubits/app_settings/app_theme_cubit.dart';
import 'package:app/app/cubits/auth/auth_cubit.dart';
import 'package:app/app_observer.dart';
import 'package:auth/auth.dart';
import 'package:core/di/injector.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  final talker = getIt<Talker>();

  Bloc.observer = AppBlocObserver(talker);

  FlutterError.onError = (details) {
    talker.log(details.exceptionAsString());
    talker.log(details.stack.toString());
  };

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppThemeCubit(getIt<AppRepository>()),
        ),
        BlocProvider(
          create: (context) => AppLocaleCubit(getIt<AppRepository>()),
        ),
        BlocProvider(create: (context) => AuthCubit(getIt<AuthRepository>())),
      ],
      child: const DemalApp(),
    ),
  );
}
