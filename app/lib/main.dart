import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:api_client/interceptors/base_interceptor.dart';
import 'package:app/app/view/app_view.dart';
import 'package:app/env.dart';
import 'package:auth_repository/auth_repository.dart';
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
        FlutterError.dumpErrorToConsole(details);
      };

      final storage = await PreferencesStorage.getInstance();

      final baseOptions = BaseOptions(
        baseUrl: Env.baseUrl,
        contentType: 'application/json; charset=utf-8',
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
      );

      final bearerDio = Dio(baseOptions)
        ..interceptors.addAll(
          [
            BaseInterceptor(
              token: () => storage.readString(key: AuthStorageKey.tokenKey),
              role: () => storage.readString(key: AuthStorageKey.roleKey),
            ),
            TalkerDioLogger(
              talker: talker,
              settings: const TalkerDioLoggerSettings(
                printRequestHeaders: true,
                printResponseHeaders: true,
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
                connection: ConnectionChecker(),
                dio: bearerDio,
              ),
            ),
          ],
          child: const App(),
        ),
      );
    },
    talker.handle,
  );
}
