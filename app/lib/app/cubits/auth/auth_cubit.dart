import 'dart:async';

import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState.initial());

  final AuthRepository _repository;

  Future<void> checkAuthStatus() async {
    try {
      final token = _repository.getToken();
      final userData = _repository.getUserData();

      if (token == null || userData == null) {
        emit(const AuthState.unauthenticated());
        return;
      }

      emit(AuthState.authenticated(userData.user, token));
    } on Object catch (e) {
      emit(AuthState.failure(e));
    }
  }

  void changeRole(Role role) {
    final currentUser = state.user;
    if (currentUser == null) return;

    emit(state.copyWith(user: currentUser.copyWith(role: role)));
  }

  void logout() async {
     _repository.logOut();
    emit(const AuthState.unauthenticated());
  }

 void deleteAccount() async {
     _repository.deleteAccount();
    emit(const AuthState.unauthenticated());
  }
}
