import 'dart:async';
import 'package:auth_repository/auth_repository.dart';
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
      final onboardingStatus = _repository.getOnboardingStatus();

      if (token == null || userData == null) {
        emit(
          AuthState.unauthenticated(hasCompletedOnboarding: onboardingStatus),
        );
        return;
      }

      emit(
        AuthState.authenticated(
          userData.user,
          token,
          hasCompletedOnboarding: onboardingStatus,
        ),
      );
    } on Object catch (e) {
      emit(AuthState.failure(e));
    }
  }

  Future<void> changeRole(Role role) async {
    await _repository.setRole(role);

    emit(state.copyWith(role: role));
  }

  Future<void> logout() async {
    final onboardingStatus = state.hasCompletedOnboarding;
    await _repository.logOut();
    emit(AuthState.unauthenticated(hasCompletedOnboarding: onboardingStatus));
  }

  Future<void> deleteAccount() async {
    await Future.wait([
      _repository.deleteAccount(),
      _repository.saveOnboardingStatus(false),
    ]);
    emit(const AuthState.unauthenticated(hasCompletedOnboarding: false));
  }

  Future<void> login(UserModel user, String token) async {
    if (!state.hasCompletedOnboarding) {
      await _repository.saveOnboardingStatus(true);
    }

    emit(AuthState.authenticated(user, token));
  }

  Future<void> completeOnboarding() async {
    await _repository.saveOnboardingStatus(true);
    emit(
      state.copyWith(
        hasCompletedOnboarding: true,
        status: AuthStatus.unauthenticated,
      ),
    );
  }
}
