import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GetIt getIt = GetIt.instance;

void setupTalker() {
  getIt.registerLazySingleton<Talker>(() => TalkerFlutter.init(settings: TalkerSettings(maxHistoryItems: 500)));
}
