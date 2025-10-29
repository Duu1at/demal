import 'package:core/api/api.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth/auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/network/network_client/network_client.dart';
import 'package:core/network/remote_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storage/storage.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<Talker>(TalkerFlutter.init());
  final Connectivity connectivity = Connectivity();

  Bloc.observer = TalkerBlocObserver(
    talker: getIt<Talker>(),
    settings: const TalkerBlocLoggerSettings(),
  );

  getIt.registerLazySingleton<NetworkClient>(
    () => NetworkClient(connectivity: connectivity),
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  getIt.registerLazySingleton<RemoteClient>(
    () => RemoteClient(dio: dio, network: getIt<NetworkClient>()),
  );

  final storage = await PreferencesStorage.getInstance();
  getIt.registerLazySingleton<PreferencesStorage>(() => storage);

  getIt.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(
      AppLocalDataSourceImpl(storage: getIt<PreferencesStorage>()),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      AuthRemoteDataSourceImpl(
        client: getIt<RemoteClient>(),
        storage: getIt<PreferencesStorage>(),
      ),
    ),
  );
}
