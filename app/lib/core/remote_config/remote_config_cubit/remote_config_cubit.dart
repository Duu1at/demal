import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigModel> {
  RemoteConfigCubit(this.repository) : super(RemoteConfigModel.empty()) {
    _configSubscription = repository.watch().listen(
      emit,
      onError: (Object error) => emit(state),
    );
  }
  final RemoteConfigRepository repository;

  StreamSubscription<RemoteConfigModel>? _configSubscription;

  Future<void> fetchRemoteConfig() async {
    try {
      final config = await repository.fetch();
      emit(config);
    } on Object catch (error, stackTrace) {
      debugPrint('Failed to fetch remote config: $error\n$stackTrace');
      emit(state);
    }
  }

  @override
  Future<void> close() {
    _configSubscription?.cancel();
    return super.close();
  }
}
