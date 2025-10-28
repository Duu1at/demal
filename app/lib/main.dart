import 'package:app/app/app_view.dart';
import 'package:app/app/cubits/app_cubit.dart';
import 'package:app/app/cubits/app_settings/app_locale_cubit.dart';
import 'package:app/app/cubits/app_settings/app_theme_cubit.dart';
import 'package:app/app_observer.dart';
import 'package:core/di/injector.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storage/storage.dart';
import 'package:talker_flutter/talker_flutter.dart';

final Talker talker = GetIt.instance<Talker>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  
  FlutterError.onError = (details) {
    talker.log(details.exceptionAsString());
    talker.log(details.stack.toString());
  };

  Bloc.observer = const AppBlocObserver();
  final storage = await PreferencesStorage.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppThemeCubit(getIt<AppRepository>()),
        ),
        BlocProvider(
          create: (context) => AppLocaleCubit(getIt<AppRepository>()),
        ),
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: const DemalApp(),
    ),
  );
}
