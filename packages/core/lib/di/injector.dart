import 'package:app_ui/app_ui.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/network/network_client/network_client.dart';
import 'package:core/network/remote_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storage/storage.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<Talker>(
    () => TalkerFlutter.init(settings: TalkerSettings(maxHistoryItems: 500)),
  );

  final Connectivity connectivity = Connectivity();

  getIt.registerSingleton(Dio());

  getIt.registerLazySingleton<NetworkClient>(
    () => NetworkClient(connectivity: connectivity),
  );

  getIt.registerLazySingleton<RemoteClient>(
    () => RemoteClient(dio: getIt<Dio>(), network: getIt<NetworkClient>()),
  );

  final storage = await PreferencesStorage.getInstance();
  getIt.registerLazySingleton<PreferencesStorage>(() => storage);

  getIt.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(
      AppLocalDataSourceImpl(storage: getIt<PreferencesStorage>()),
    ),
  );
}
