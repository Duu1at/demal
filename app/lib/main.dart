import 'package:app/app/app_view.dart';
import 'package:app/app/cubits/app_settings/app_locale_cubit.dart';
import 'package:app/app/cubits/app_settings/app_theme_cubit.dart';
import 'package:app/app/cubits/auth/auth_cubit.dart';
import 'package:auth/auth.dart';
import 'package:core/di/injector.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  FlutterError.onError = (details) {
    getIt<Talker>().log(details.exceptionAsString());
    getIt<Talker>().log(details.stack.toString());
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
