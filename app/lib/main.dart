import 'dart:async';

import 'package:app/app/app_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/api/api.dart';
import 'package:core/keys/storage_keys.dart';
import 'package:core/network/network_client/network_client.dart';
import 'package:core/network/remote_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/storage.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
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
      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<PreferencesStorage>(create: (context) => storage),
            RepositoryProvider<NetworkClient>(
              create: (context) => NetworkClient(connectivity: Connectivity()),
            ),
            RepositoryProvider<RemoteClient>(
              create: (context) => RemoteClient(
                dio: Dio(
                  BaseOptions(
                    baseUrl: Api.baseUrl,
                    connectTimeout: const Duration(seconds: 100),
                    receiveTimeout: const Duration(seconds: 100),
                  ),
                ),
                network: context.read<NetworkClient>(),
                resolveAppRole: () => storage.readString(key: StorageKeys.roleKey),
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
