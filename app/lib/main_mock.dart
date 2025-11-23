import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:app/app/view/app_view_mock.dart';
import 'package:app/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/storage.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Main функция с использованием мок-данных для тестирования
///
/// Для использования мок-режима:
/// 1. Переименуйте main.dart в main_real.dart
/// 2. Переименуйте main_mock.dart в main.dart
/// 3. Или измените импорт в main.dart на app_view_mock.dart
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
      final connectionChecker = ConnectionChecker();

      final baseOptions = BaseOptions(
        baseUrl: Env.baseUrl,
        contentType: 'application/json; charset=utf-8',
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
      );

      final bearerDio = Dio(baseOptions)
        ..interceptors.addAll(
          [
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
          ],
          // Используем AppMock вместо App
          // Можете указать статус верификации для тестирования:
          // mockVerificationStatus: PartnerVerifyStatusEnum.pending,
          // mockVerificationStatus: PartnerVerifyStatusEnum.verified,
          // mockVerificationStatus: PartnerVerifyStatusEnum.rejected,
          child: const AppMock(
            // Для тестирования разных сценариев раскомментируйте нужный:
            // mockVerificationStatus: PartnerVerifyStatusEnum.pending,
            // mockVerificationStatus: PartnerVerifyStatusEnum.verified,
            // mockVerificationStatus: PartnerVerifyStatusEnum.rejected,
          ),
        ),
      );
    },
    talker.handle,
  );
}
