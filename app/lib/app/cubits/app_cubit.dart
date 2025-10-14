import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  Future<void> changeRole({required Role role}) async {
    emit(state.copyWith(role: role));
  }
}
