import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetStatus { initial, connected, disconnected }

class ConnectivityCubit extends Cubit<InternetStatus> {
  ConnectivityCubit(ConnectionChecker connectionChecker)
    : _connectionChecker = connectionChecker,
      super(InternetStatus.initial) {
    _init();
  }

  final ConnectionChecker _connectionChecker;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void _init() {
    _subscription = _connectionChecker.connectivity.onConnectivityChanged.listen(_checkConnection);
  }

  Future<void> _checkConnection(List<ConnectivityResult> result) async {
    if (_connectionChecker.isConnected(result)) {
      emit(InternetStatus.connected);
    } else {
      emit(InternetStatus.disconnected);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
