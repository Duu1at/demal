import 'dart:async';
import 'package:api_client/api_client.dart';
import 'package:api_client/interceptors/app_interceptor.dart';
import 'package:app/app/view/app_view.dart';
import 'package:app/core/core.dart' as app_core;
import 'package:app/firebase_options.dart';
import 'package:app/env.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/storage.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  final talker = TalkerFlutter.init();
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final crashlyticsService = app_core.FirebaseCrashlyticsService(
        FirebaseCrashlytics.instance,
      );
      final crashlyticsClient = CrashlyticsClientImpl(crashlyticsService);

      final analyticsService = app_core.FirebaseAnalyticsService(
        FirebaseAnalytics.instance,
        crashlyticsClient,
      );
      final remoteConfigService = app_core.FirebaseRemoteConfigService(
        FirebaseRemoteConfig.instance,
        crashlyticsClient,
      );

      await remoteConfigService.fetchAndActivate();

      Bloc.observer = TalkerBlocObserver(
        talker: talker,
        settings: const TalkerBlocLoggerSettings(
          printEventFullData: false,
          printStateFullData: false,
          printChanges: true,
          printClosings: true,
          printCreations: true,
        ),
      );

      FlutterError.onError = (details) {
        talker
          ..error(details.exceptionAsString())
          ..error(details.stack.toString());
        crashlyticsService.report(details.exception, details.stack);
        FlutterError.dumpErrorToConsole(details);
      };

      final storage = await PreferencesStorage.getInstance();
      final connectionChecker = ConnectionChecker();

      final baseOptions = BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
      );

      final bearerDio = Dio(baseOptions)
        ..interceptors.addAll(
          [
            AppInterceptor(
              token: () => storage.readString(key: AuthStorageKey.tokenKey),
            ),
            TalkerDioLogger(
              talker: talker,
              settings: const TalkerDioLoggerSettings(
                printRequestHeaders: true,
              ),
            ),
          ],
        );

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<PreferencesStorage>(create: (context) => storage),
            RepositoryProvider<ApiClient>(
              create: (context) => ApiClient.fromDio(
                connection: connectionChecker,
                dio: bearerDio,
              ),
            ),
            RepositoryProvider<AnalyticsService>.value(value: analyticsService),
            RepositoryProvider<CrashlyticsService>.value(value: crashlyticsService),
            RepositoryProvider<RemoteConfigService>.value(value: remoteConfigService),
          ],
          child: const App(),
        ),
      );
    },
    (error, stack) {
      talker.handle(error, stack);
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}
