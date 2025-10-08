import 'package:app/app/app_view.dart';
import 'package:app/app_observer.dart';
import 'package:app/core/di/setup_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

final Talker talker = GetIt.instance<Talker>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupTalker();
  FlutterError.onError = (details) {
    talker.log(details.exceptionAsString());
    talker.log(details.stack.toString());
  };

  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}
